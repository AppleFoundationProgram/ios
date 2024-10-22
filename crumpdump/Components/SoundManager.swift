import AVFoundation

class SoundManager: NSObject, AVAudioPlayerDelegate {
    static let shared = SoundManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var onSoundCompletion: (() -> Void)?
    
    // onCompletion을 옵셔널로 설정
    func playSound(soundName: String, onCompletion: (() -> Void)? = nil) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.delegate = self
                audioPlayer?.play()
                
                // 완료 콜백 설정
                onSoundCompletion = onCompletion
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    func stopSoundAfter(seconds: TimeInterval) {
        Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { [weak self] _ in
            self?.stopSound()
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        onSoundCompletion = nil
    }

    func pauseSound() {
        audioPlayer?.pause()
    }

    func resumeSound() {
        audioPlayer?.play()
    }
    
    func toggleSound(soundName: String) {
        if let player = audioPlayer {
            if player.isPlaying {
                // 현재 재생 중이면 일시 정지
                pauseSound()
            } else {
                // 현재 일시 정지 중이거나 정지 상태이면 재생 시작
                resumeSound()
            }
        } else {
            // 현재 소리가 재생 중이지 않으면 새로 재생 시작
            playSound(soundName: soundName)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer = nil
        
        // onSoundCompletion이 설정된 경우에만 호출
        onSoundCompletion?()
        onSoundCompletion = nil
    }
}
