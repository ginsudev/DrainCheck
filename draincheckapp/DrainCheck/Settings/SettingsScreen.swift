//
//  SettingsScreen.swift
//  DrainCheck
//
//  Created by Noah Little on 25/9/2022.
//

import SwiftUI

struct SettingsScreen: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DrainCheckPrefsViewController {
        return DrainCheckPrefsViewController()
    }

    func updateUIViewController(_ uiViewController: DrainCheckPrefsViewController, context: Context) {
    
    }
}
