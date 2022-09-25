//
//  ResultsBox.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

enum Gain {
    case increase, none, decrease
}

struct ResultsBox: View {
    var gain: Gain
    var elapsedTime: String
    var battery: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(Image(systemName: imageNameForGain())) + Text(" \(battery)%")
            }
            .foregroundColor(colourForGain())
            
            ZStack(alignment: .center) {
                VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                    .frame(width: .infinity, height: 6)
                    .cornerRadius(3)
                
                Rectangle()
                    .fill(
                        RadialGradient(colors: [Color(UIColor.systemBackground),
                                                Color(UIColor.systemBackground).opacity(0.0)],
                                       center: .center, startRadius: 20, endRadius: 45)
                    )
                    .frame(width: .infinity, height: 6)
                
                Text(elapsedTime)
            }
        }
    }
    
    private func colourForGain() -> Color {
        switch gain {
        case .increase:
            return .green
        case .none:
            return .blue
        case .decrease:
            return .red
        }
    }
    
    private func imageNameForGain() -> String {
        switch gain {
        case .increase:
            return "arrow.up.circle"
        case .none:
            return "minus.circle"
        case .decrease:
            return "arrow.down.circle"
        }
    }
}
