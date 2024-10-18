import SwiftUI
import CoreMotion

struct ThrowView: View {
    @State private var showAlert = true
    @State private var navigateToHome = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            VStack {
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()
                
                Spacer()
                
                CustomButton(title: "시작으로", backgroundColor: .blue) {
                    navigateToHome = true
                }
            }
            .navigationTitle("던지기")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showAlert) {
                SafetySheetView()
            }
            .onAppear {
                showAlert = true
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
            }
        }
    }
}

struct ThrowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ThrowView()
        }
    }
}
