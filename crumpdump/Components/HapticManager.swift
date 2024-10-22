import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    func triggerRandomImpactHaptic(count: Int) {
        for _ in 0..<count {
            let randomStyle: UIImpactFeedbackGenerator.FeedbackStyle = [.light, .medium, .heavy].randomElement()!
            let generator = UIImpactFeedbackGenerator(style: randomStyle)
            generator.prepare()
            generator.impactOccurred()
            
            Thread.sleep(forTimeInterval: 0.2)
        }
    }
}
