//
//  KeywordCapsule.swift
//  crumpdump
//
//  Created by taenee on 10/14/24.
//

import SwiftUI

struct KeywordCapsule: View {
    let keyword: String
    let symbol: String
    let color: Color
    
    @ScaledMetric(relativeTo: .title) var paddingWidth = 10
    
    var body: some View {
        Label(keyword, systemImage: symbol)
            .font(.caption)
            .foregroundColor(.white)
            .padding(paddingWidth)
            .background {
                Capsule()
                    .fill(color.opacity(0.75))
            }
    }
}

struct KeywordCapsule_Previews: PreviewProvider {
    static let keywords = ["test", "test2", "test3"]
    static var previews: some View {
        HStack {
            ForEach(keywords, id: \.self) { keyword in
                KeywordCapsule(keyword: keyword, symbol: "star", color: Color.red)
            }
        }
    }
}
