//
//  AlbumHorizontalSectionView.swift
//  MoodyMusic
//
//  Created by Nathapong Masathien on 1/3/25.
//

import SwiftUI

struct AlbumHorizontalSectionView: View {
    
//    let onAlbumTap:() -> Void
    var onAlbumTap: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Section title
            Text("Recently Played")
                .font(.title)
                .bold()
                .padding(.leading)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { index in
                        AlbumCardView {
                            print("Print tapped in AlbumHorizontalSectionView")
                            onAlbumTap?()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AlbumHorizontalSectionView()
}
