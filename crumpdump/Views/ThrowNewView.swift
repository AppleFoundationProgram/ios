import SwiftUI
import CoreMotion

class AppState: ObservableObject {
    @Published var isThrowCompleted = false
    func resetThrow() {
        isThrowCompleted = false
    }
}

struct ThrowNewView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var motionCatcher = MotionCatcher()
    @State private var showInfo = false
    @State private var navigateToHome = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var throwSceneVisible = false
    @State private var throwScene = ThrowScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    @State private var currentImageName: String = "open_mouth"
    
    @State private var throwInfoText: String = "감구리에게 당신의 부정적인 감정을 던져주세요!"
    @State private var statusEmotionalText: String = "마음 속에 있는 부정적인 감정들을\n비워내보면 어떨까요?"
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        VStack {
                            Spacer()
                            Image(currentImageName)
                        }
                        
                        if throwSceneVisible {
                            ThrowSceneView(scene: throwScene)
                        }
                        
                        VStack {
                            Text(throwInfoText)
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                                .padding()
                            
                            Text(statusEmotionalText)
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.black)
                                .padding()
                            
                            Spacer()
                            
                            GifImage("frog")
                                .opacity(throwSceneVisible ? 0 : 1)
                        }
                    }
                    
                    HStack {
                        CustomButton(title: "시작으로", backgroundColor: appState.isThrowCompleted ? .blue : Color.gray.opacity(0.3)) {
                            navigateToHome = true
                        }
                        .disabled(!appState.isThrowCompleted)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .navigationTitle("던지기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showInfo) {
                SafetySheetView()
            }
            .onAppear {
                showInfo = true
                motionCatcher.startMotionUpdates()
            }
            .onDisappear {
                motionCatcher.stopMotionUpdates()
            }
            .onChange(of: motionCatcher.isThrowDetected) { before, after in
                if after && !before {
                    throwSceneVisible = true
                    motionCatcher.stopMotionUpdates()
                    throwNote(direction: motionCatcher.throwDirection)
                }
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
    
    func throwNote(direction: ThrowDirection) {
        // 진동
        HapticManager.shared.triggerRandomImpactHaptic(count: 5)
        
        // 효과음
        SoundManager.shared.playSound(soundName: "throw_start.mp3")
        SoundManager.shared.stopSoundAfter(seconds: 4)
        
        // ThrowScene을 보이게 설정
        throwSceneVisible = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            throwScene.animateCircle(from: direction) {
                currentImageName = "close_mouth"
                SoundManager.shared.playSound(soundName: "chomp.mp3", onCompletion: {
                    appState.isThrowCompleted = true
                    
                    throwInfoText = "감구리 나쁜 감정을 먹어버렸어요!"
                    statusEmotionalText = "비워진 마음에 새로운 감정이나 좋은 감정을 채우시길 바래요!"
                })
            }
        }
    }
}

struct ThrowNewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ThrowNewView()
                .environmentObject(AppState())
        }
    }
}
