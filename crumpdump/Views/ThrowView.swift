import SwiftUI

struct ThrowView: View {
    @State private var notePosition = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    @State private var throwAnimationStarted = false
    @State private var dollPosition = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2 - 150)
    @State private var noteXOffset: CGFloat = 0
    @State private var noteYOffset: CGFloat = 0
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                // 인형 이미지
                Image("doll")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .position(x: dollPosition.width, y: dollPosition.height)

                Spacer()

                // 던질 쪽지 이미지
                Image("crumpled_note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .offset(x: noteXOffset, y: noteYOffset) // 포물선 경로를 위한 X, Y 오프셋
                    .animation(throwAnimationStarted ? Animation.easeInOut(duration: 1.5) : .default)

                Spacer()

                // 던지기 애니메이션을 시작하는 버튼
                CustomButton(title: "던지기 시작", backgroundColor: .blue) {
                    throwNote() // 버튼을 누르면 애니메이션 실행
                }
            }
            .navigationTitle("던지기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // 던지기 애니메이션 실행 함수
    func throwNote() {
        throwAnimationStarted = true // 애니메이션 시작
        feedbackGenerator.impactOccurred() // 진동 피드백

        // 포물선을 그리며 인형을 향해 날아가는 애니메이션
        withAnimation(Animation.easeInOut(duration: 1.5)) {
            noteXOffset = dollPosition.width - UIScreen.main.bounds.width + 150 // X축 이동
            noteYOffset = dollPosition.height - UIScreen.main.bounds.height + 300 // Y축 이동 (포물선 형태)
        }
    }
}

struct ThrowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThrowView()
        }
    }
}
