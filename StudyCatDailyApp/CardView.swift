//
//  CardModel.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 23.07.25.
//

import Foundation
import SwiftUI

struct CardView: View {
    @StateObject var model:CardModel
    @Binding var tapCount:Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 4))
                .frame(width: 300, height: 300)
                .overlay(
                    AsyncImage(url: URL(string: model.catImage ?? "" ))
                        .mask {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 300, height: 300)
                        }
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .overlay( RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300, height: 300)
                            .foregroundStyle(Color.white)
                            .opacity(model.isFlipped ? 0 : 1)
                            .animation(.spring(duration: 0.5), value: tapCount))
                    
                )
                .onTapGesture {
                    if tapCount < 3 {
                        if tapCount < 2{
                            SoundManager.shared.playSound(named: "splash")
                        }
                        model.isFlipped = false
                        tapCount += 1
                        withAnimation(.spring(duration: 0.2)){
                            model.tapped.toggle()
                            print("tapped")
                        } completion: {
                            withAnimation(.spring(duration: 0.1)){
                                model.tapped.toggle()
                            }
                        }
                    }
                    if tapCount == 3 {
                        SoundManager.shared.playSound(named: "baby")
                        model.isFlipped = true
                    }
                }
        }
        .task {
            model.isLoaded = false
           
        }
        
        .position(x: UIScreen.main.bounds.width / 2, y: tapCount == 3 ? UIScreen.main.bounds.height / 2 - 200 : UIScreen.main.bounds.height / 2 - 100 )
        .rotation3DEffect(.degrees(tapCount == 3 ? 355 : 0), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(tapCount == 3 ? 2 : 0), axis: (x: 1, y: 0, z: 1))
        .rotationEffect(.degrees(model.tapped ? 3 : 0))
        .scaleEffect(model.tapped ? 1.1 : 1)
        .animation( .spring(duration: 0.6), value: tapCount)
        .animation( .spring(duration: 2).delay(1.5), value: model.isFlipped)
        .shadow(color: .white ,radius: tapCount == 3 ? 5 : 0)
    }
}

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


