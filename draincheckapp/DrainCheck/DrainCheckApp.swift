//
//  DrainCheckApp.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

@main
struct DrainCheckApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                LogList()
                    .tabItem {
                        Label("Logs", systemImage: "list.dash")
                    }
                
                SettingsScreen()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .ignoresSafeArea()
                
                AboutScreen()
                    .tabItem {
                        Label("Credits", systemImage: "star")
                    }
            }
        }
    }
}
