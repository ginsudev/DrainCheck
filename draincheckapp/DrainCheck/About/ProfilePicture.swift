//
//  ProfilePicture.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct ProfilePicture: View {
    var twitterHandle: String
    @State var picture: UIImage = UIImage(systemName: "person.circle.fill")!
    
    var body: some View {
        Image(uiImage: picture)
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .shadow(radius: 10)
            .overlay(Circle().stroke(.white, lineWidth: 3))
            .onAppear {
                fetchImage()
            }
    }
    
    func fetchImage() {
        DispatchQueue.global().async {
            if let url = URL(string: "https://unavatar.io/twitter/\(twitterHandle)?fallback=false") {
                
                guard let data = try? Data(contentsOf: url) else {
                    self.picture = UIImage(systemName: "person.circle.fill")!
                    return
                }
                
                self.picture = UIImage(data: data)!
            }
        }
    }
}
