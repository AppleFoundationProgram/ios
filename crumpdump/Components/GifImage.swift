import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    private let webView = WKWebView()
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            GifImage("frog")
                .frame(width: 300, height: 300)
                .background(Color.red)
                .cornerRadius(15)
                .padding()
            
            Image("open_mouth")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
            
            
            GifImage("frog")
                .frame(width: 150, height: 150)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
                .hidden()
                .alignmentGuide(.bottom) { d in d[.bottom] }
        }.background(.black)
    }
}
