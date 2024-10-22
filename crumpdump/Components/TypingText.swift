import SwiftUI

struct TypingText: View {
    @State private var displayedText: [String] = []
    @State private var currentLineIndex = 0
    
    let fullText: [String]
    private let typingSpeed = 0.2
    var isHidden: Bool
    var onTypingComplete: (() -> Void)? // callback

    var isTypingComplete: Bool {
        currentLineIndex >= fullText.count
    }

    var body: some View {
        if !isHidden {
            VStack(spacing: 10) {
                ForEach(displayedText, id: \.self) { line in
                    Text(line)
                        .font(.title)
                        .animation(.easeInOut, value: displayedText)
                }
            }
            .onAppear {
                startTyping()
            }
        }
    }

    private func startTyping() {
        guard currentLineIndex < fullText.count else { return }
        
        let currentLine = fullText[currentLineIndex]
        var displayedLine = ""
        displayedText.append(displayedLine)

        Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if displayedLine.count < currentLine.count {
                displayedLine.append(currentLine[currentLine.index(currentLine.startIndex, offsetBy: displayedLine.count)])
                displayedText[currentLineIndex] = displayedLine
            } else {
                timer.invalidate()
                currentLineIndex += 1
                
                if currentLineIndex >= fullText.count {
                    onTypingComplete?()
                } else {
                    startTyping()
                }
            }
        }
    }

    func restartTyping() {
        displayedText.removeAll()
        currentLineIndex = 0
        startTyping()
    }
}

struct TypingText_Previews: PreviewProvider {
    static var previews: some View {
        TypingText(fullText: ["우울한", "짜증이 나는", "스트레스 받는"], isHidden: false)
    }
}
