//
//  AlbumCardView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct AlbumCardView: View {
    
    var onTap: (() -> Void)? = nil
//    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: "music.note")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .background(.gray)
            
            Text("Bohemian Rhapsody")
                .font(.headline)
                .bold()
                .frame(width: 150, alignment: .leading)
                .lineLimit(1)
            
            Text("Queen")
                .font(.subheadline)
                .frame(width: 150, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.bottom, 4)
        .onTapGesture {
            print("Tapped")
            onTap?() //callback
        }
    }
}

#Preview {
    AlbumCardView()
}
