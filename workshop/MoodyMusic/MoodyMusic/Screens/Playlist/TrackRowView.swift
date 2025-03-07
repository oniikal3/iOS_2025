//
//  TrackRowView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct TrackRowView: View {
    
    private let url = URL(string: "https://picsum.photos/200")
    
    var body: some View {
        HStack(spacing: 16) {
            // Track number
            Text("01")
                .font(.headline)
                .padding(.horizontal, 4)
            
            // Cover image
            AsyncImage(url: url) { image in
                // โหลดรูปได้
                image
                    .resizable()
            } placeholder: {
                // ระหว่างรอโหลดรูป
                Color.gray
            }
            .frame(width: 60, height: 60)
            
            // Track title and artist name
            VStack(alignment: .leading) {
                Text("Bohemian Rhapsody")
                    .font(.headline)
                    .bold()
                Text("Queen")
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Options button
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }


        }
    }
}

#Preview {
    TrackRowView()
}
