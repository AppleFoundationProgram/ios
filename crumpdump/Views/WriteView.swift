import SwiftUI

struct WriteView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToEmotionView: Bool = false
    @State private var textInput: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("어떤 기억이 \n당신을 힘들게 하고 있나요?")
                    .font(.title2)
                    .padding([.leading, .trailing, .top])
                
                Text("자유롭게 당신의 마음을 적어주세요.\n어떤 생각이든, 어떤 감정이든 좋아요!")
                    .font(.custom("SF Pro Display", size: 14))
                    .foregroundColor(.gray)
                    .lineSpacing(6)
                    .padding([.leading, .trailing, .top])
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $textInput)
                        .padding(5)
                        .background(!textInput.isEmpty ? Color.blue.opacity(0.2) : Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .animation(.easeInOut(duration: 0.3), value: textInput)
                }
                .padding([.leading, .trailing], 16)
                .frame(height: 300)
                
                Spacer()
                
                CustomButton(title: "다음", backgroundColor: textInput.isEmpty ? Color.gray.opacity(0.3) : Color.blue) {
                    navigateToEmotionView = true
                }
                .disabled(textInput.isEmpty)
            }
            .padding()
            .navigationTitle("기록하기")
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
            .navigationDestination(isPresented: $navigateToEmotionView) {
                SelectEmotionView()
            }
        }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WriteView()
        }
    }
}
