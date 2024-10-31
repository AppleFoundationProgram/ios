import SwiftUI

struct SafetySheetView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("throw")
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
            Text("Physical Discharge Techniques는 신체의 긴장과 스트레스를 해소하기 위해 신체 활동을 활용하는 방법입니다.\n이 기법은 신체적 에너지를 안전하게 분출함으로써 감정적, 정신적 부담을 줄이는 데 도움을 줄 수 있습니다.")
                .foregroundColor(Color.black)
                .padding()
            
            Image("warning")
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
            Text("1. 모션 시 핸드폰을 던지지 않도록 주의해주세요.\n2. 다른 사람이나 물건에 부딪히지 않도록 주의해주세요.")
                .foregroundColor(Color.black)
                .padding()
            Spacer()
            CustomButton(title: "닫기", backgroundColor: .blue) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .background(Color.white)
        .padding()
    }
}

struct SafetySheetView_View: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SafetySheetView()
        }
    }
}
