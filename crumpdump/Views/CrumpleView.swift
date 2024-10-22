import SwiftUI
import AVFoundation

struct CrumpleView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @Binding var bindEmotionList: [String]
    @State private var navigateToThrow: Bool = false
    @State private var explainMessage = "버리고 싶은 감정을 작성하고 있어요!"
    @State private var audioPlayer: AVAudioPlayer?
    @State private var touchTimer: Timer?
    @State private var imageTimer: Timer?
    
    private let period: TimeInterval = 3
    private let imageCount = 95
    
    @State private var typingComplete = false
    @State private var currentImage = 1
    @State private var startTime: Date?
    @State private var totalTouchTime: TimeInterval = 0
    @State private var isTouching = false
    @State private var crumpleDone = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("\(currentImage)")
                    .resizable()
                    .scaledToFill()
                
                VStack {
                    Text(explainMessage)
                        .font(.title2)
                        .foregroundColor(currentImage > 41 ? Color.white : Color.gray)
                        .padding()
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    TypingText(fullText: bindEmotionList, isHidden: currentImage > 41) {
                        typingComplete = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            explainMessage = "종이를 구길 준비가 됐습니다!\n종이를 꾸욱 눌러 구겨주세요!"
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    if crumpleDone {
                        HStack {
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
                    ThrowNewView()
                }
            }
        }
        .onLongPressGesture(minimumDuration: 0.1, pressing: { pressing in
            if typingComplete {
                if pressing {
                    if !isTouching && !crumpleDone {
                        startCrumple()
                    }
                } else {
                    stopCrumple()
                }
            }
        }) {}
            .onDisappear {
                stopCrumple()
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
                    stopCrumple()
                }
            }
    }
    
    func startCrumple() {
        isTouching = true
        if !crumpleDone {
            startTouchTimer()
            startImageTimer()
            playAudio()
        }
    }
    
    private func startTouchTimer() {
        startTime = Date()
        totalTouchTime = 0
        touchTimer?.invalidate()
        
        touchTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            if let startTime = self.startTime {
                self.totalTouchTime = Date().timeIntervalSince(startTime)
                crossCheckCrumpleDone()
                if !self.crumpleDone {
                    self.triggerHapticFeedback()
                }
            }
        }
    }
    
    private func startImageTimer() {
        let imageChangeInterval = period / Double(imageCount)
        
        imageTimer?.invalidate()
        imageTimer = Timer.scheduledTimer(withTimeInterval: imageChangeInterval, repeats: true) { _ in
            if self.currentImage < self.imageCount && !self.crumpleDone {
                self.currentImage += 1
            }
        }
    }
    
    private func crossCheckCrumpleDone() {
        if totalTouchTime >= period || currentImage >= imageCount {
            crumpleDone = true
            explainMessage = "종이를 모두 구겼습니다!!"
            stopCrumple()
        }else{
            
            explainMessage = "종이를 꾸욱 눌러야 구겨집니다!"
        }
        
    }
    
    func stopCrumple() {
        isTouching = false
        touchTimer?.invalidate()
        touchTimer = nil
        if let startTime = startTime {
            totalTouchTime += Date().timeIntervalSince(startTime)
        }
        startTime = nil
        stopAudio()
        imageTimer?.invalidate()
        imageTimer = nil
    }
    
    func resetPaper() {
        stopCrumple()
        currentImage = 1
        totalTouchTime = 0
        crumpleDone = false
        explainMessage = "종이를 꾸욱 눌러야 구겨집니다!"
    }
    
    private func triggerHapticFeedback() {
        let feedbackStyles: [UIImpactFeedbackGenerator.FeedbackStyle] = [.light, .medium, .heavy, .rigid, .soft]
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
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Failed to play sound: \(error.localizedDescription)")
            }
        }
    }
    
    private func stopAudio() {
        if let player = audioPlayer, player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
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
