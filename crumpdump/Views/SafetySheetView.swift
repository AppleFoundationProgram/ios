import SwiftUI

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

            Spacer()

            CustomButton(title: "닫기", backgroundColor: .blue) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}
