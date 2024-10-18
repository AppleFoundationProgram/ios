import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var navigateToWrite: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("CrumpDump")
                    .font(.custom("SF Pro Display", size: 40).weight(.bold))
                    .foregroundColor(.blue)
                    .padding(.bottom, 40)
                
                Spacer()
                
                CustomButton(title: "시작하기", backgroundColor: .blue) {
                    navigateToWrite = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToWrite) {
                WriteView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
