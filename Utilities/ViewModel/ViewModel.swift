//
//  ViewModel.swift
//  WidgetApp
//
//  Created by Ganesh Raju Galla on 21/12/23.
//

import Foundation

class ViewModel:ObservableObject{
    
    // MARK: - Properties
    
    @Published var photos:[Photos]?
    
    
    
    // Methods
    
    @MainActor
    func getPhotos() async {
        do{
            photos = try await APIClient.sendRequest(endPoint: .getPhotos)
        }catch{
            print("Error:",error.localizedDescription)
        }
    }
}
