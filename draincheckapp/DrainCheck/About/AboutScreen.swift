//
//  About.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        NavigationView {
            List(creators()) { creator in
                Profile(creator: creator)
            }
            .navigationTitle("Credits")
            .listStyle(.insetGrouped)
        }
        .navigationViewStyle(.stack)
    }
    
    private func creators() -> [Creator] {
        var arr = [Creator]()
        
        arr.append(Creator(name: "Noah",
                           developerName: "Ginsu",
                           twitterHandle: "ginsudev",
                           role: "Developer"))
        
        arr.append(Creator(name: "Baxter",
                           developerName: "Bank5ia",
                           twitterHandle: "bank5ia",
                           role: "App & icon designer"))
        
        return arr
    }
}
