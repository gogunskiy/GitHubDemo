//
//  DetailsView.swift
//  GithubClient
//
//  Created by vgogunsky on 16.02.2024.
//

import SwiftUI
import UIKit
import WebKit

struct DetailsView: View {
    let url: URL
    
    var body: some View {
        NavigationStack {
            WebView(url: url)
        }.navigationTitle("Repo Details")
    }
}


struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let request = URLRequest(url: url)
        wkwebView.load(request)
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
