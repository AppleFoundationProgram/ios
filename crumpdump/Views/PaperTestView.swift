import SwiftUI
import AVFoundation

struct PaperTestView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isTouching = false
    @State private var zing = ""
    @State private var period: TimeInterval = 3
    
    @State private var startTime: Date? = nil
    @State private var totalTouchTime: TimeInterval = 0
    @State private var timer: Timer? = nil
    @State private var showMessage = false
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            Text("터치하면 소리와 진동이 울림\n\(zing)")
                .padding()
                .onLongPressGesture(minimumDuration: 0.01, pressing: { pressing in
                    if pressing {
                        startFeedback()
                    } else {
                        stopFeedback()
                    }
                }) {
                }
            
            Text("터치한 시간: \(Int(totalTouchTime))초")
                .padding()
            
            if showMessage {
                Text("터치 시간이 \(Int(period))초를 초과했습니다!")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    func startFeedback() {
        // 터치 중일 때 진동 및 소리 재생 시작
        isTouching = true
        zing = "지이이이잉"
        
        startTime = Date() // 터치 시작 시간 기록
        
        // 타이머 시작
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let startTime = startTime {
                totalTouchTime += Date().timeIntervalSince(startTime)
                self.startTime = Date()
                if totalTouchTime >= period {
                    showMessage = true
                    stopFeedback()
                }
            }
        }
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
        
        if isPaused {
            audioPlayer?.play()
            isPaused = false
        } else {
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
    }
    
    func stopFeedback() {
        isTouching = false
        zing = ""
        
        timer?.invalidate()
        timer = nil
        
        if let startTime = startTime {
            totalTouchTime += Date().timeIntervalSince(startTime)
        }
        self.startTime = nil
        
        if let player = audioPlayer, player.isPlaying {
            player.pause()
            isPaused = true
        }
    }
}

struct PaperTestView_Previews: PreviewProvider {
    static var previews: some View {
        PaperTestView()
    }
}
