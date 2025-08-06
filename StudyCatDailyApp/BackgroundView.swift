//
//  BackgroundView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 6.08.25.
//

import SwiftUI

struct BackgroundView: View {
   
    @State var isShowing = false
    var body: some View {
        ForEach(0..<20){ x in
            HStack() {
                ForEach(0..<20) { i in
                    VStack(){
                        
                        Text("💘")
                                    .opacity(0.7)
                                    .font(.system(size: 50))
                            }
                            .frame(width: 50, height: 50)
                            
                    
                        
                }
            }

        }
            .offset(x: isShowing ? 55 : 0 , y:  isShowing ? 55 : 0)
            .animation(.linear(duration: 4).repeatForever(autoreverses: false), value: isShowing)
            .onAppear {
                    isShowing.toggle()
            }
            
        }
   
       
       
    
        
    }

//#Preview {
//    BackgroundView()
//}
