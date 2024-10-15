//
//  crumpdumpApp.swift
//  crumpdump
//
//  Created by Jiwon Kim on 10/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = true  // 앱이 시작할 때 Sheet가 보이도록 기본값을 true로 설정

    var body: some View {
        NavigationView {
            VStack {
                Image("Image") // 여기에 이미지를 추가하세요.
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding()

                Button(action: {
                    showAlert.toggle()
                }) {
                    Text("던지기")
                        .font(.system(size: 24))
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("던지기")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAlert) {
                SafetySheetView()
            }
            .onAppear {
                // 앱이 시작될 때 Sheet가 보이도록 설정
                showAlert = true
            }
        }
    }
}

struct SafetySheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("안전한 사용을 위한 주의 사항")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


