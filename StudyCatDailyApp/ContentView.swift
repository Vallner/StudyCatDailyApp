//
//  ContentView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 16.07.25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        
        ZStack {
            if viewModel.tapCount < 3 {
                Color.black
                    .ignoresSafeArea()
            } else {
                LinearGradient(colors: [.blue,.green, .red] , startPoint: .leading, endPoint:.trailing)
                    .ignoresSafeArea()
                    .hueRotation(.degrees(viewModel.gradientAnimation ? 360 : 0))
                    .onAppear {
                        withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                            viewModel.gradientAnimation.toggle()
                        }
                           
                    }
                    
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
                    
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(style: StrokeStyle(lineWidth: 4))
                            .frame(width: 300, height: 300)
                            .overlay(
                                AsyncImage(url: URL(string: viewModel.catImage ?? "" ))
                                    .mask {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 300, height: 300)
                                    }
                                    .frame(width: 300, height: 300)
                                    .task {
                                        await viewModel.getCatImage()
                                        
                                    }
                                    .alert(isPresented: $viewModel.isError) {
                                        Alert(title: Text("Failed to load image"), message: Text("Please try again later."), dismissButton: .cancel(Text("Retry"), action: {
                                            Task {
                                                viewModel.catImage = nil
                                                await  viewModel.getCatImage()
                                            }
                                        }))
                                        
                                    }
                                    .overlay( RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 300, height: 300)
                                        .foregroundStyle(Color.white)
                                        .opacity(viewModel.tapCount == 3 ? 0 : 1)
                                        .animation(.spring(duration: 0.5), value: viewModel.tapCount))
                                    .scaledToFit()
                            )
                        
                        
                        
                    }
                    .onTapGesture {
                        if viewModel.tapCount < 3 {
                            self.viewModel.tapCount += 1
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.tapped.toggle()
                            }
                            withAnimation(.easeInOut(duration: 0.2).delay(0.2)) {
                                viewModel.tapped.toggle()
                            }
                        }
                    }
                    
                    .position(x: UIScreen.main.bounds.width / 2, y: viewModel.tapCount == 3 ? 200 : UIScreen.main.bounds.height / 2 - 100 )
                    .rotation3DEffect(.degrees(viewModel.tapCount == 3 ? 355 : 0), axis: (x: 0, y: 1, z: 0))
                    .rotation3DEffect(.degrees(viewModel.tapCount == 3 ? 2 : 0), axis: (x: 1, y: 0, z: 1))
                    .rotationEffect(.degrees(viewModel.tapped ? 3 : 0))
                    .scaleEffect(viewModel.tapped ? 1.1 : 1)
                    .animation( .spring(), value: viewModel.tapCount)
                    .shadow(color: .white ,radius: viewModel.tapCount == 3 ? 5 : 0)
                    Text(viewModel.randomDescription!)
                        .foregroundStyle( Color.white )
                        .opacity(viewModel.tapCount == 3 ? 1 : 0)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 300)
//                        .animation(.spring(duration: 0.5), value: viewModel.tapCount)
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .shadow(color: .white ,radius: 10)
                        
                    Button("Reload") {
                        viewModel.tapCount = 0
                        Task {
                            await  viewModel.getCatImage()
                        }
                    }
                    Spacer()
                }
            }
            
            
        }
        .animation(.linear(duration: 2), value: viewModel.tapCount == 3)
        
    }
    
}

#Preview {
    ContentView()
}
