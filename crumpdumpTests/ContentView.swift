//import SwiftUI

struct ContentView: View {
    @State private var isSheetPresented = false // Sheet 표시 여부를 제어하는 상태 변수

    var body: some View {
        VStack {
            Button(action: {
                isSheetPresented = true // 버튼 클릭 시 Sheet 표시
            }) {
                Text("던지기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            InstructionSheetView() // Sheet에 표시될 내용
        }
    }
}

struct InstructionSheetView: View {
    @Environment(\.presentationMode) var presentationMode // Sheet를 닫기 위한 환경 변수

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("안전한 사용을 위한 유의사항\n1. 실제 핸드폰을 던지지 마세요.\n이 앱은 쪽지를 던지는 느낌을 주기 위한 모션을 제공합니다. 그러나 핸드폰을 실제로 던지지 않도록 주의하세요.\n\n2. 충분한 공간을 확보하세요.\n핸드폰을 흔드는 동작을 할 때 주변 물건과의 충돌을 방지하기 위해 넉넉한 공간에서 사용해 주세요.")
                .font(Font.custom("SF Pro", size: 24).weight(.semibold))
                .foregroundColor(.black)
                .frame(width: 388, alignment: .leading)

            Button("닫기") {
                presentationMode.wrappedValue.dismiss() // Sheet를 닫음
            }
            .font(.headline)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea() // 전체 화면에 걸쳐서 배경색 적용
    }
}

struct ImageSheetView: View {
    @Environment(\.presentationMode) var presentationMode // Sheet를 닫기 위한 환경 변수

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 473, height: 932)
                .background(
                    Image("PATH_TO_IMAGE")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 473, height: 932)
                        .clipped()
                )

            Button("닫기") {
                presentationMode.wrappedValue.dismiss() // Sheet를 닫음
            }
            .font(.headline)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea() // 전체 화면에 걸쳐서 배경색 적용
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
