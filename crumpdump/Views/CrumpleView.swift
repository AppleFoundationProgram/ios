import SwiftUI

struct CrumpleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToThrow: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                CustomButton(title: "쪽지 던지기", backgroundColor: .blue) {
                    navigateToThrow = true
                }
            }
            .padding()
            .navigationTitle("쪽지 구기기")
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
            .navigationDestination(isPresented: $navigateToThrow) {
                ThrowView()
            }
        }
    }
}

struct CrumpleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CrumpleView()
        }
    }
}
