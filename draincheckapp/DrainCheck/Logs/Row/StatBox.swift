//
//  StatBox.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct StatBox: View {
    var percentage: Int
    var time: String
    
    var body: some View {
        ZStack {            
            VStack {
                Text("\(percentage)%")
                Text(time)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
        .cornerRadius(10)
    }
}
