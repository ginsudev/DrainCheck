//
//  Settings.swift
//  
//
//  Created by Noah Little on 24/9/2022.
//

import Foundation

@objc enum AutomaticActivationType: Int {
    case none = 0, dnd = 1, lpm = 2
}

struct Settings {
    static var isEnabled: Bool!
    static var automaticActivation: AutomaticActivationType!
}
