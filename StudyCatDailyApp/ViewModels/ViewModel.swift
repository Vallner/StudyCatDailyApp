//
//  ViewModel.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 20.07.25.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    
    @Published var showText: Bool = false
    @Published var startAnimationPlayed = false
    @Published var startUpAnimationBegin: Bool = false
    @Published var tapCount: Int = 0
    @Published var gradientAnimation: Bool = false
    var description: [String] = ["Wow its you!", "You are amazing!", "You are cool!", "For Alina with love!", "Pretty cool huh?", "Try your best!", "Today is a great day!", "❤️","💖","💘","💝","💖","💗","💘","💝","😘","🙈","💅"]
    var backgroundEmogis: [String] = ["❤️","💖","💘","💝","💖","💗","💘","💝","😘","🙈"]
}
