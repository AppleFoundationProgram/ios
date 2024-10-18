import SwiftUI

struct CustomButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
            .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
            .padding()
            .background(backgroundColor)
            .cornerRadius(8)
            .frame(maxWidth: .infinity)
        }
        .padding([.leading, .trailing, .bottom], 16)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Test Button", backgroundColor: .blue) {
            print("Button tapped")
        }
    }
}
