//
//  ContentView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 16.07.25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var startAnimationPlayed = false
    @State var startUpAnimationBegin: Bool = false
    @State var gradientAnimation: Bool = false
    var body: some View {
        
        ZStack {
            if viewModel.tapCount < 3 {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color.clear
                    .ignoresSafeArea()
                    .background(Gradient(colors: gradientAnimation ? [.blue, .red] : [.red, .blue]))
                    .animation(.linear(duration: 2), value: gradientAnimation)
                    .onAppear {
                        gradientAnimation.toggle()
                        withAnimation(.linear(duration: 6).delay(4)) {
                            gradientAnimation.toggle()
                        }
                    }
                    
            }
            Text("Cat of the day")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            
                .foregroundColor(.white)
                .padding()
                .rotation3DEffect(.degrees(startUpAnimationBegin ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                .position(x: UIScreen.main.bounds.width / 2, y: startAnimationPlayed ? 30 : (UIScreen.main.bounds.height / 2 - 100))
                .animation(.easeInOut(duration: 1.5),value: startUpAnimationBegin)
                .onAppear {
                    
                    withAnimation(.linear(duration: 1)) {
                        startUpAnimationBegin = true
                    } completion: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            startAnimationPlayed = true
                        }
                        
                    }
                }
            
            if startAnimationPlayed {
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
                    Text(viewModel.catImageDescription ?? "")
                        .foregroundStyle(viewModel.tapCount == 3 ? Color.white : .black)
                        .opacity(viewModel.tapCount == 3 ? 1 : 0)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 - 300)
                        .animation(.spring(duration: 0.5), value: viewModel.tapCount)
                    Button("Reload") {
                        viewModel.tapCount = 0
                        Task {
                            viewModel.catImage = nil
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
