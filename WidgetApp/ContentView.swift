//
//  ContentView.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = ViewModel()
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.photos ?? [], id: \.self) { photo in
                    HStack(spacing: 20){
                        imageView(urlString: photo.thumbnailURL ?? "")
                            .frame(width: 100,height: 100)
                        
                        Text(photo.title ?? "")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.gray)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Json Placeholders")
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
        }
        .task {
            await viewModel.getPhotos()
        }
    }
}


// MARK: - ContentView

extension ContentView{
    private func imageView(urlString:String) -> some View{
        AsyncImage(url: .init(string: urlString)) { image in
            image
                .resizable()
                .scaledToFill()
                .clipped()
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    ContentView()
}
