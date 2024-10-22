import SwiftUI
import CoreMotion

// throwView 때문에 제거
//class AppState: ObservableObject {
//    @Published var isThrowCompleted = false
//    
//    func resetThrow() {
//        isThrowCompleted = false
//    }
//}

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

    @State private var dataCounter = 0

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

                if abs(accel.x) > 3 || abs(accel.y) > 3 || abs(accel.z) > 3 ||
                   abs(rotation.x) > 10 || abs(rotation.y) > 10 || abs(rotation.z) > 10 {
                    print("Throw 감지됨!")
                    throwNote()
                }
            }
        } else {
            print("DeviceMotion 사용 불가")
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
