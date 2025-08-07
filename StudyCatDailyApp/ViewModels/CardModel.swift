//
//  CardModel.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 7.08.25.
//
import SwiftUI

class CardModel: ObservableObject {
    
    @Published  var catImage: String?
    @Published  var isLoaded: Bool = false
    @Published var isFlipped: Bool = false
    //        @Published  var tapCount: Binding<Int>
    @Published var tapped: Bool = false
    @Published var isError: Bool = false
    @MainActor
    func getCatImage() async {
        do{
            catImage = try await NetManager.shared.fectchImageURL()
            //            catImageDescription = try await netManager.fetchImageURL().1
            if catImage != nil {
                print("Succes")
                isError = false
            }
        }
        catch {
            print("Error")
            isError = true
        }
    }
    //    init(tapCount: Binding<Int>) {
    //        self.tapCount = tapCount
    //    }
}
