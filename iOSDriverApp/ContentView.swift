//
//  ContentView.swift
//  iOSDriverApp
//

import SwiftUI

struct ContentView: View {
    @State private var showWelcome = true

    var body: some View {
        if showWelcome {
            WelcomeView(showWelcome: $showWelcome)
        } else {
            NavigationStack {
                MainMenuView()
            }
        }
    }
}

#Preview {
    ContentView()
}
