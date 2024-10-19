import SwiftUI
import AVFoundation

struct CrumpleView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @Binding var bindEmotionList: [String]
    @State private var navigateToThrow: Bool = false
    @State private var explainMessage = "종이를 터치하면 구겨집니다!"
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var touchTimer: Timer? = nil
    @State private var imageTimer: Timer? = nil
    
    private let period: TimeInterval = 2
    private let imageCount = 95
    
    @State private var currentImage = 1
    @State private var startTime: Date? = nil
    @State private var totalTouchTime: TimeInterval = 0
    
    @State private var isPaused = false
    @State private var isPressed = false
    @State private var isTouching = false
    @State private var crumpleDone = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image("\(currentImage)")
                    .resizable()
                    .scaledToFill()
                    .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
                        if pressing {
                            if self.totalTouchTime >= self.period {
                                crumpleDone = true
                                stopCrumple()
                            }else{
                                startCrumple(crumpleDone: crumpleDone)
                            }
                        } else {
                            if crumpleDone {
                                explainMessage = "종이를 모두 구겼습니다!!"
                            }
                            stopCrumple()
                        }
                    }) {}
                
                VStack {
                    Text(explainMessage)
                        .font(.caption)
                        .foregroundColor(currentImage > 31 ? Color.white : Color.black)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    TypingText(fullText: bindEmotionList, isHidden: currentImage > 31)
                        .foregroundColor(Color.black)
                    Spacer()
                    
                    if crumpleDone {
                        HStack{
                            CustomButton(title: "다시 구기기", backgroundColor: .gray) {
                                resetPaper()
                            }
                            
                            CustomButton(title: "쪽지 던지기", backgroundColor: .blue) {
                                navigateToThrow = true
                            }
                        }
                    }
                }
                .navigationTitle("쪽지 구기기")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
                .navigationDestination(isPresented: $navigateToThrow) {
                    ThrowView()
                }
            }
        }
        .onDisappear {
            stopCrumple()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
                stopCrumple()
            }
        }
    }
    
    func startCrumple(crumpleDone: Bool) {
        isTouching = true
        if crumpleDone {
            stopCrumple()
            return
        }
        startTouchTimer()
    }

    private func startTouchTimer() {
        startTime = Date()
        totalTouchTime = 0
        touchTimer?.invalidate()

        touchTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if let startTime = self.startTime {
                let currentTime = Date()
                self.totalTouchTime = currentTime.timeIntervalSince(startTime)

                if self.totalTouchTime >= self.period {
                    self.crumpleDone = true
                    self.stopCrumple()
                } else {
                    if !self.crumpleDone {
                        if self.imageTimer == nil {
                            self.startImageTimer()
                        }
                        self.triggerHapticFeedback()
                        self.playAudio()
                    }
                }
            }
        }
    }

    private func startImageTimer() {
        let imageChangeInterval = period / Double(imageCount - 1)
        imageTimer?.invalidate()

        imageTimer = Timer.scheduledTimer(withTimeInterval: imageChangeInterval, repeats: true) { _ in
            if currentImage < imageCount {
                currentImage += 1
            } else {
                imageTimer?.invalidate()
                imageTimer = nil
            }
        }
    }

    private func triggerHapticFeedback() {
        let feedbackStyles: [UIImpactFeedbackGenerator.FeedbackStyle] = [
            .light,
            .medium,
            .heavy,
            .rigid,
            .soft
        ]
        
        let randomStyle = feedbackStyles.randomElement() ?? .medium
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: randomStyle)
        feedbackGenerator.impactOccurred()
    }

    private func playAudio() {
        if audioPlayer?.isPlaying == true {
            return
        }

        if let soundURL = Bundle.main.url(forResource: "crumping", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1 // 무한 반복
                audioPlayer?.play()
            } catch {
                print("Failed to play sound: \(error.localizedDescription)")
            }
        }
    }


    func stopCrumple() {
        isTouching = false
        
        touchTimer?.invalidate()
        touchTimer = nil
        
        imageTimer?.invalidate()
        imageTimer = nil
        
        if let startTime = startTime {
            totalTouchTime += Date().timeIntervalSince(startTime)
        }
        self.startTime = nil
        
        if let player = audioPlayer, player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
    }
    
    func resetPaper() {
        stopCrumple()
        currentImage = 1
        totalTouchTime = 0
        crumpleDone = false
        explainMessage = "종이를 터치하면 구겨집니다!"
    }
}

struct CrumpleView_Previews: PreviewProvider {
    @State static var previewEmotionList: [String] = ["안좋은감정1", "안좋은감정2", "안좋은감정3"]
    static var previews: some View {
        NavigationStack {
            CrumpleView(bindEmotionList: $previewEmotionList)
        }
    }
}

