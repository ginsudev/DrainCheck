//
//  EmptyListView.swift
//  DrainCheck
//
//  Created by Noah Little on 25/9/2022.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("🚫")
                .font(.system(size: 50))
                .padding()
            Text("Looks like there's no drain logs to display. Start logging by activating the control centre module.")
        }
        .multilineTextAlignment(.center)
        .foregroundColor(Color(UIColor.secondaryLabel))
    }
}
