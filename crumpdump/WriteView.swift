//
//  WriteView.swift
//  crumpdump
//
//  Created by Jiwon Kim on 10/14/24.
//

import SwiftUI

struct WriteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var navigateToEmotionView: Bool = false
    @State private var textInput: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("무슨 일이 당신을 힘들게하나요?")
                .font(.title2)
                .padding([.leading, .trailing, .top])
            
            Text("자유롭게 표현해주세요.\n글을 다 작성하셨다면, 쪽지를 작성한 후 인형에 던져보세요.")
                .font(.custom("SF Pro Display", size: 14))
                .foregroundColor(.gray)
                .lineSpacing(6)
                .padding([.leading, .trailing, .top])
            
            // 기록하기
            ZStack(alignment: .topLeading) {
                TextEditor(text: $textInput)
                    .padding()
                    .background(!textInput.isEmpty ? Color.blue.opacity(0.2) : Color(UIColor.systemGray6))
                    .cornerRadius(8)
            }
            .padding([.leading, .trailing], 16)
            .frame(height: 300)
            
            Spacer()
            
            // 쪽지 작성하기 이동 버튼
            NavigationLink(destination: SelectEmotionView()) {
                HStack {
                    Spacer()
                    Text("다음")
                        .foregroundColor(.black)
                    Spacer()
                }
                .font(Font.custom("SF Pro Display", size: 16).weight(.semibold))
                .padding()
                .background(textInput.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
            }
            .disabled(textInput.isEmpty)
            .padding([.leading, .trailing, .bottom], 16)
            .frame(maxWidth: .infinity)

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
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WriteView()
        }
    }
}
