//
//  ResultsBox.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

enum Gain
{
    case increase, none, decrease
}

struct ResultsBox: View
{
    var gain: Gain
    var elapsedTime: String
    var battery: Int
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text(Image(systemName: imageNameForGain())) + Text(" \(battery)%")
            }
            .foregroundColor(colourForGain())
            
            ZStack(alignment: .center)
            {
                Rectangle()
                    .frame(width: .infinity, height: 6)
                    .cornerRadius(3)
                    .foregroundColor(colourForGain())
                
                VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
                    .frame(width: .infinity, height: 6)
                    .overlay(
                        Rectangle()
                        .fill(
                            RadialGradient(colors: [Color(UIColor.systemBackground),
                                                    Color(UIColor.systemBackground).opacity(0.0)],
                                           center: .center,
                                           startRadius: 20,
                                           endRadius: 45)
                        ))
                    .cornerRadius(3)
                
                Text(elapsedTime)
            }
        }
    }
    
    private func colourForGain() -> Color
    {
        switch gain
        {
        case .increase:
            return .green
        case .none:
            return .blue
        case .decrease:
            return .red
        }
    }
    
    private func imageNameForGain() -> String
    {
        switch gain
        {
        case .increase:
            return "arrow.up.circle"
        case .none:
            return "minus.circle"
        case .decrease:
            return "arrow.down.circle"
        }
    }
}

struct VisualEffectView: UIViewRepresentable
{
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView
    {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>)
    {
        uiView.effect = effect
    }
}
