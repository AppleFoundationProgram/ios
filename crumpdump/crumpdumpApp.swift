//
//  crumpdumpApp.swift
//  crumpdump
//
//  Created by Jiwon Kim on 10/14/24.
//

import SwiftUI

@main
struct crumpdumpApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(appState)
        }
    }
}

