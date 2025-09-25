//
//  EsImage_Previews.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//


import SwiftUI
// MARK: - Previews
#Preview("Light") {
    VStack(spacing: 20) {
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: Circle())
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: Rectangle())
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: RoundedRectangle(cornerRadius: 8))
        ESImage(systemName: "cart.circle.fill", size: 60, clipShape: Circle(), tint: .blue)
        ESImage(assetName: "person", size: 60, clipShape: RoundedRectangle(cornerRadius: 10))
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.light)
}

#Preview("Dark") {
    VStack(spacing: 20) {
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: Circle())
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: Rectangle())
        ESImage(url: "https://i.pravatar.cc/300", size: 60, clipShape: RoundedRectangle(cornerRadius: 8))
        ESImage(systemName: "star.fill", size: 60, clipShape: Circle(), tint: .yellow)
        ESImage(assetName: "person", size: 60, clipShape: RoundedRectangle(cornerRadius: 10))
    }
    .padding()
    .background(Color.bg)
    .preferredColorScheme(.dark)
}
