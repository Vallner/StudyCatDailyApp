//
//  CatCardView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 16.07.25.
//

import SwiftUI

struct CatCardView: View {
   
    @State var isFlipped: Bool = false
    @State var tappedCount: Int = 0
    @State var tapped : Bool = false
    var body: some View {
        
        if  tappedCount < 3 {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.yellow)
                .frame(width: 300, height: 300)
                .overlay(
                    Text("Hello, World!")
                        .font(.headline)
                        .foregroundColor(.black)
                )
                .scaleEffect(tapped ? 1.2 : 1)
                .rotationEffect(.degrees(tapped  ? 10 : 0))
            //                .animation(.bouncy(duration: 0.2).delay(0.2).repeatForever(autoreverses: true), value: tappedCount)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2 )) {
                        tapped.toggle()
                        tappedCount += 1
                    }
                    withAnimation(.easeInOut(duration: 0.2).delay(0.2).repeatCount(1, autoreverses: true)){
                        tapped.toggle()
                    }
                    
                }
        }else {
                RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 270, height: 270)
                            .overlay(
                                Text("Hello, World!")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            )
                            .rotation3DEffect(.degrees(isFlipped ? 2160 : 0), axis: (x: 0, y: 1, z: 0))
                            .rotation3DEffect(.degrees(isFlipped ? 10 : 0), axis: (x: 1, y: 0, z: 0))
                            .rotation3DEffect(.degrees(isFlipped ? -10 : 0), axis: (x: 0, y: 1, z: 0))
                            .offset(x: -10, y: isFlipped ? -150 : 0)
                            .animation(.easeInOut(duration: 1.5), value: isFlipped)
                            .onAppear {
                                isFlipped = true
                                
                            }
   
                }
        }
    }


