//
//  Creator.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import Foundation

struct Creator: Identifiable {
    var id = UUID()
    var name: String
    var developerName: String
    var twitterHandle: String
    var role: String
}
