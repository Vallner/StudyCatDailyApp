//
//  ContentView.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 16.07.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
               CatCardView()
                    .onAppear {
                        print("onAppear")
                    }
                
                Spacer()
                    }
               
            }
        }
    }


#Preview {
    ContentView()
}
