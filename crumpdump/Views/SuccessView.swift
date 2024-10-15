//
//  SuccessView.swift
//  crumpdump
//
//  Created by taenee on 10/14/24.
//

import SwiftUI

struct SuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("쪽지를 던져버렸습니다!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("감정이 비워진 자리에\n발견하지 못했던 감정을 찾거나 \n새로운 감정으로 채워보면 어떨까요?")
                .font(.title2)
                .foregroundColor(Color.gray)
                .padding()
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Text("돌아가기")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    SuccessView()
}
