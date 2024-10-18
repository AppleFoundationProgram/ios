import SwiftUI
import CoreMotion
import CoreML

class AppState: ObservableObject {
    @Published var isThrowCompleted = false
    
    func resetThrow() {
        isThrowCompleted = false
    }
}

struct ThrowView: View {
    @EnvironmentObject var appState: AppState
    @State private var showAlert = true
    @State private var navigateToHome = false
    @State private var motionManager = CMMotionManager()
    @State private var throwAnimationStarted = false
    @State private var noteXOffset: CGFloat = 0
    @State private var noteYOffset: CGFloat = 0
    @State private var dollPosition = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2 - 150)
    @Environment(\.presentationMode) var presentationMode
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    let throwingModel: ThrowAndNotThrow

    @State private var accelXData = [Double](repeating: 0, count: 100)
    @State private var accelYData = [Double](repeating: 0, count: 100)
    @State private var accelZData = [Double](repeating: 0, count: 100)
    @State private var gyroXData = [Double](repeating: 0, count: 100)
    @State private var gyroYData = [Double](repeating: 0, count: 100)
    @State private var gyroZData = [Double](repeating: 0, count: 100)
    @State private var dataCounter = 0

    init() {
        do {
            let config = MLModelConfiguration()
            throwingModel = try ThrowAndNotThrow(configuration: config)
        } catch {
            fatalError("ThrowAndNotThrow 모델 초기화 실패: \(error.localizedDescription)")
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Image("doll")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .position(x: dollPosition.width, y: dollPosition.height)

                Image("crumpled_note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .offset(x: noteXOffset, y: noteYOffset)
                    .animation(throwAnimationStarted ? .easeInOut(duration: 1.5) : .default, value: noteXOffset)

                Spacer()

                CustomButton(title: "시작으로", backgroundColor: appState.isThrowCompleted ? .blue : Color.gray.opacity(0.3)) {
                    navigateToHome = true
                }
                .disabled(!appState.isThrowCompleted)
            }
            .navigationTitle("던지기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showAlert) {
                SafetySheetView()
            }
            .onAppear {
                showAlert = true
                resetThrowState()
                stopMotionUpdates()
                startMotionUpdates()
            }
            .onDisappear {
                stopMotionUpdates()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
                    .onAppear {
                        appState.resetThrow()
                    }
            }
        }
    }

    func resetThrowState() {
        throwAnimationStarted = false
        noteXOffset = 0
        noteYOffset = 0
        dataCounter = 0
        appState.isThrowCompleted = false
    }

    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: .main) { motionData, error in
                guard let data = motionData else { return }

                let accel = data.userAcceleration
                let rotation = data.rotationRate

                if self.dataCounter < 100 {
                    self.accelXData[self.dataCounter] = accel.x
                    self.accelYData[self.dataCounter] = accel.y
                    self.accelZData[self.dataCounter] = accel.z
                    self.gyroXData[self.dataCounter] = rotation.x
                    self.gyroYData[self.dataCounter] = rotation.y
                    self.gyroZData[self.dataCounter] = rotation.z
                    self.dataCounter += 1
                }

                if self.dataCounter == 100 {
                    let accelXArray = try? MLMultiArray(self.accelXData)
                    let accelYArray = try? MLMultiArray(self.accelYData)
                    let accelZArray = try? MLMultiArray(self.accelZData)
                    let gyroXArray = try? MLMultiArray(self.gyroXData)
                    let gyroYArray = try? MLMultiArray(self.gyroYData)
                    let gyroZArray = try? MLMultiArray(self.gyroZData)

                    let stateIn = try? MLMultiArray(shape: [400], dataType: .double)

                    let modelInput = ThrowAndNotThrowInput(
                        Acceleration_X: accelXArray!,
                        Acceleration_Y: accelYArray!,
                        Acceleration_Z: accelZArray!,
                        Gyro_X: gyroXArray!,
                        Gyro_Y: gyroYArray!,
                        Gyro_Z: gyroZArray!,
                        stateIn: stateIn!
                    )

                    if let prediction = try? throwingModel.prediction(input: modelInput) {
                        if prediction.label == "Throw" {
                            throwNote()
                        }
                    }

                    self.dataCounter = 0
                }
            }
        }
    }

    func throwNote() {
        throwAnimationStarted = true
        feedbackGenerator.impactOccurred()

        withAnimation(.easeInOut(duration: 1.5)) {
            noteXOffset = dollPosition.width - UIScreen.main.bounds.width + 200
            noteYOffset = dollPosition.height - UIScreen.main.bounds.height + 300
        }

        stopMotionUpdates()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            appState.isThrowCompleted = true
        }
    }

    func stopMotionUpdates() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

struct ThrowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ThrowView()
                .environmentObject(AppState())
        }
    }
}
