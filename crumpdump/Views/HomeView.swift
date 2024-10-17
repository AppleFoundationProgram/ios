import SwiftUI

struct HomeView: View {
    @State private var navigateToWrite: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // 중간에 CrumpDump 로고 텍스트
                Text("CrumpDump")
                    .font(.custom("SF Pro Display", size: 40).weight(.bold))
                    .foregroundColor(.blue)
                    .padding(.bottom, 40)
                
                Spacer()
                
                // 하단에 시작하기 버튼
                NavigationLink(destination: WriteView()) {
                    HStack {
                        Spacer()
                        Text("시작하기")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)                    .frame(maxWidth: .infinity)
                }
                .padding([.leading, .trailing, .bottom], 16)
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 전체 화면을 차지하게 설정
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
