//
//  Profile.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct Profile: View
{
    @Environment(\.openURL) var openURL
    var creator: Creator
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                ProfilePicture(twitterHandle: creator.twitterHandle)
                
                VStack(alignment: .leading)
                {
                    Text("\(creator.name) (\(creator.developerName))")
                        .font(.title2)
                    Text(creator.role)
                        .font(.title3)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                
                Spacer()
                
                Image(systemName: "person.crop.circle.badge.plus")
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
        }
        
        .padding(.vertical)
        
        .onTapGesture
        {
            openURL(URL(string: "https://twitter.com/\(creator.twitterHandle)")!)
        }
    }
}
