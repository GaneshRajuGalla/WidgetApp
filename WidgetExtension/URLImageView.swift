//
//  URLImageView.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 22/12/23.
//

import Foundation
import SwiftUI

struct URLImageView: View {
    let url: URL

    @ViewBuilder
    var body: some View {
        if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        } else {
            Image(systemName: "photo")
                .resizable()
        }
    }
}
