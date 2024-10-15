import SwiftUI

struct ThrowView: View {
    @State private var showAlert = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image("Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding()

            NavigationLink(destination: ThrowActionView()) {
                Text("던지기")
                    .font(.system(size: 24))
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            Spacer() // 빈 공간을 채워서 버튼을 아래로 배치
        }
        .navigationTitle("던지기")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showAlert) {
            SafetySheetView()
        }
        .onAppear {
            showAlert = true // 앱이 시작될 때 Sheet가 보이도록 설정
        }
        .toolbar { // 툴바에 뒤로가기 버튼 추가
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

// 던지기 이후의 화면
struct ThrowActionView: View {
    var body: some View {
        VStack {
            Text("던지기 이후 화면")
                .font(.largeTitle)
                .padding()

            Image("throw_action_image") // 던지는 동작을 나타내는 이미지를 추가하세요.
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding()

            Text("여기서 물체를 던지는 동작을 할 수 있습니다.")
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("던지기 액션")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 안전한 사용을 위한 주의사항을 보여주는 Sheet
struct SafetySheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("안전한 사용을 위한 주의사항")
                .font(.headline)
                .padding()

            Text("""
            1. 실제 핸드폰을 던지지 마세요. 이 앱은 쪽지를 던지는 느낌을 주기 위한 모션을 제공합니다. 그러나 핸드폰을 실제로 던지지 않도록 주의하세요.

            2. 충분한 공간을 확보하세요. 핸드폰을 흔드는 동작을 할 때 주변 물건과의 충돌을 방지하기 위해 넉넉한 공간에서 사용해 주세요.
            """)
                .font(.body)
                .padding()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("닫기")
                    .font(.system(size: 20))
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct ThrowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThrowView()
        }
    }
}
