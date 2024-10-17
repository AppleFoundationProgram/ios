import SwiftUI

struct CrumpleNewView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToThrow: Bool = false
    
    var body: some View {
        VStack {
            Spacer()

            Spacer()

            // 하단에 시작하기 버튼
            NavigationLink(destination: ThrowView()) {
                HStack {
                    Spacer()
                    Text("쪽지 던지기")
                        .foregroundColor(.white)
                    Spacer()
                }
                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
            }
            .padding([.leading, .trailing, .bottom], 16)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .navigationTitle("크럼플")
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
    }
}

struct CrumpleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CrumpleNewView()
        }
    }
}
