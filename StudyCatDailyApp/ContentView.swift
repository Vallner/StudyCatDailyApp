//
//  ContentView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 16.07.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var cardModel = CardModel()
    @State var tapCount: Int = 0
    @State var gradientAnimation: Bool = false
    var body: some View {
        
        ZStack {
           

            Color.black.edgesIgnoringSafeArea(.all)
            LinearGradient(colors: tapCount == 3 ? [.blue,.green, .red] : [.black,.black, .black] , startPoint: .leading, endPoint:.trailing)
                
                                .ignoresSafeArea()
                                .hueRotation(.degrees(gradientAnimation ? 360 : 0))
                                .onAppear {
                                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                                        gradientAnimation.toggle()
                                    }
                                
                                }
                                .mask {
                                    BackgroundView()
                                }
   
            Text("Cat of the day")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .shadow(color: .black ,radius: 5, x: 0, y: 5)
                .foregroundColor(.white)
                .padding()
                .rotation3DEffect(.degrees(viewModel.startUpAnimationBegin ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                .position(x: UIScreen.main.bounds.width / 2, y: viewModel.startAnimationPlayed ? 30 : (UIScreen.main.bounds.height / 2 - 100))
                .animation(.easeInOut(duration: 1.5),value: viewModel.startUpAnimationBegin)
                .onAppear {
                    withAnimation(.linear(duration: 1)) {
                        viewModel.startUpAnimationBegin = true
                        
                    } completion: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.startAnimationPlayed = true
                        }
                    }
                }
            
            if viewModel.startAnimationPlayed {
                
                VStack {
                    
                    CardView(model: cardModel, tapCount: $tapCount)
                    if tapCount == 3 {
                        Text(cardModel.isFlipped ? viewModel.description.randomElement()! : " ")
                            .opacity(cardModel.isFlipped ? 1 : 0)
                                .foregroundStyle( Color.white )
                                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 300)
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .shadow(color: .white ,radius: 10)
                                .animation(.linear(duration: 2).delay(1.5), value: cardModel.isFlipped)
                        Button("Reload") {
                            tapCount = 0
                            cardModel.isFlipped.toggle()
                            SoundManager.shared.player?.stop()
                        }
                        .padding()
                        .background(Color(white: 1,opacity: 0.3))
                        .foregroundStyle( Color.white )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .task {
                            await cardModel.getCatImage()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .animation(.spring(duration: 0.5), value: tapCount)
        
    }
    
}

#Preview {
    ContentView()
}

