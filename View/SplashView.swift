//
//  SplashView.swift
//  breezz
//
//  Created by Артем Дорожкин on 03.01.2022.
//

import SwiftUI

struct SplashView: View {
    
    @State var animation: Animation = Animation.easeOut(duration: 2).repeatForever(autoreverses: true)
    @State var ison = false
    var body: some View {
        ZStack {
            ZStack{
                
                let randomDouble1 = Double.random(in: -500...500)
                let randomDouble2 = Double.random(in: -500...500)
                let randomDouble3 = Double.random(in: -500...500)
                
                Capsule()
                    .frame(width: 150 , height: 125)
                    .foregroundColor(.accentColor)
                    .rotationEffect(.degrees(ison ? randomDouble1 : 0))
                    .opacity(0.5)
                    .scaleEffect(ison ? 1.71 : 1)
                    .animation(ison ? animation: .default)
                
                Capsule()
                    .frame(width: 150 , height: 140)
                    .foregroundColor(.accentColor)
                    .opacity(0.4)
                    .scaleEffect(ison ? 1.83 : 1)
                    .rotationEffect( .degrees(ison ? randomDouble2 : 0))
                    .animation(ison ? animation: .default)
                
                Capsule()
                    .frame(width: 150 , height: 100)
                    .foregroundColor(.accentColor)
                    .opacity(0.3)
                    .scaleEffect(ison ? 1.62 : 1)
                    .rotationEffect(.degrees(ison ? randomDouble3 : 0))
                    .animation(ison ? animation: .default)
            }
        Circle()
            .frame(width: 150 , height: 150)
            .foregroundColor(.accentColor)
            .scaleEffect(ison ? 1.5 : 1)
            .animation(ison ? animation: .default)
            
            VStack {
                Text("Welcome to")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .opacity(ison ? 1:0)
                    .animation(ison ? animation: .default)
                Spacer()
                Text("breezz")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                    .opacity(ison ? 1:0)
                    .animation(ison ? animation: .default)
            }.padding()
        }.padding(.top, 40.0)
        .onAppear() {
            ison = true
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
