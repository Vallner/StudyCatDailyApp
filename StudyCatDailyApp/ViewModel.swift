//
//  ViewModel.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 20.07.25.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    let netManager: NetManager = NetManager().shared
    @Published var catImage: String?
    @Published var catImageDescription: String?
    @Published var gradientAnimation: Bool = false
    @Published var startAnimationPlayed = false
    @Published var startUpAnimationBegin: Bool = false
    var text = "Hello, World!"
    @Published var isLoaded: Bool = false
    @Published var tapCount: Int = 0
    @Published var tapped: Bool = false
    @Published var isError: Bool = false
    var randomDescription: String? {
        description.randomElement()
    }
    private var description: [String] = ["Wow its you!", "You are amazing!", "You are cool!", "For Alina with love!", "Pretty cool huh?", "Try your best!", "Today is a great day!", "❤️","💖","💕","💞","💓","💗","💘","💝","💖","💗","💘","💝","😘","🙈","💅"]
    func getCatImage() async {
        do{
            catImage = try await netManager.fectchImageURL()
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
}
