//
//  CircleView.swift
//  breezz
//
//  Created by Артем Дорожкин on 15.11.2021.
//

import SwiftUI

struct CircleView: View {
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    let haptic = UIImpactFeedbackGenerator()
    private let timerBreach = Timer.publish(every: 1, on: .main, in: .common)
    
    @Binding var isOn: Bool
    @Binding var hale: Bool
    @Binding var selected: Int
    
    @State var tain: Bool = false
    @State var tain1: Bool = false
    
    @Binding var showInhale: Bool
    @Binding var showRetain: Bool
    @Binding var showExhale: Bool
    @Binding var showSustain: Bool
    
    @Binding var animation: Animation 
    
    
    
    var body: some View {
        
       
        
        ZStack {
            VStack {
                ZStack{
                    Text(
                        showInhale ? ("Inhale ") : (
                            showRetain ? ("Retain ") : (
                                showExhale ? ("Exhale ") :(
                                    showSustain ? ("Sustain") : ("")
                                )
                            )
                        )
                    )
                        .font(.title)
                        .fontWeight(.light)
                        
                        
                   
                }
                .padding(.vertical, 50.0)
                .opacity(isOn ? 1.0 : 0)
                .animation(.easeInOut)
                Spacer()
            }
            ZStack{
                ZStack{
                    
                    let randomDouble1 = Double.random(in: -200...200)
                    let randomDouble2 = Double.random(in: -200...200)
                    let randomDouble3 = Double.random(in: -200...200)

                    
                    Capsule()
                        .frame(width: (showInhale ? (150.0) : (showRetain ? (150.0 * 1.41) : (showExhale ? (150.0 * 1.41) :(showSustain ? (150.0) : (150.0))))) , height: (showInhale ? (125.0) : (showRetain ? (125.0 * 1.41) : (showExhale ? (125.0 * 1.41) :(showSustain ? (125.0) : (125.0))))))
                        .foregroundColor(.accentColor)
                        .rotationEffect(.degrees(randomDouble1))
                        .opacity(0.5)
                        .scaleEffect(isOn ? (showInhale ? (1.41) : (showRetain ? (1.0) : (showExhale ? (1.0/1.41) :(showSustain ? (1.0) : (1.0)))) ):(1.0))
                        .animation(isOn ? animation : .default)
                    
                    Capsule()
                        .frame(width: (showInhale ? (150.0) : (showRetain ? (150.0 * 1.43) : (showExhale ? (150.0 * 1.43) :(showSustain ? (150.0) : (150.0))))) , height: (showInhale ? (140.0) : (showRetain ? (140.0 * 1.43) : (showExhale ? (140.0 * 1.43) :(showSustain ? (140.0) : (140.0))))))
                        .foregroundColor(.accentColor)
                        .opacity(0.4)
                        .scaleEffect(isOn ? (showInhale ? (1.43) : (showRetain ? (1.0) : (showExhale ? (1.0/1.43) :(showSustain ? (1.0) : (1.0)))) ):(1.0))
                        .rotationEffect(.degrees(randomDouble2))
                        .animation(isOn ? animation : .default)
                    
                    Capsule()
                        .frame(width: (showInhale ? (150.0) : (showRetain ? (150.0 * 1.42) : (showExhale ? (150.0 * 1.42) :(showSustain ? (150.0) : (150.0))))) , height: (showInhale ? (100.0) : (showRetain ? (100.0 * 1.42) : (showExhale ? (100.0 * 1.42) :(showSustain ? (100.0) : (100.0))))))
                        .foregroundColor(.accentColor)
                        .opacity(0.3)
                        .scaleEffect(isOn ? (showInhale ? (1.42) : (showRetain ? (1.0) : (showExhale ? (1.0/1.42) :(showSustain ? (1.0) : (1.0)))) ):(1.0))
                        .rotationEffect(.degrees(randomDouble3))
                        .animation(isOn ? animation : .default)
                }
                
                Circle()
                    .frame(width: (showInhale ? (150.0) : (showRetain ? (150.0 * 1.30) : (showExhale ? (150.0 * 1.30) :(showSustain ? (150.0) : (150.0))))) , height: (showInhale ? (150.0) : (showRetain ? (150.0 * 1.30) : (showExhale ? (150.0 * 1.30) :(showSustain ? (150.0) : (150.0))))))
                    .foregroundColor(.accentColor)
                    .scaleEffect(isOn ? (showInhale ? (1.30) : (showRetain ? (1.0) : (showExhale ? (1.0/1.30) :(showSustain ? (1.0) : (1.0)))) ):(1.0))
                    .animation(isOn ? animation : .default)
                
                    }
                  
        }
                
    }
}

struct CircleView_Previews: PreviewProvider {
    @State static var isOn = false
    @State static var hale = false
    @State static var select = 1
    @State static var showInhale = false
    @State static var showRetain = false
    @State static var showExhale = false
    @State static var showSustain = false
    @State static var animation: Animation = Animation.easeOut(duration: 3).delay(3).repeatForever(autoreverses: true)
    static var previews: some View {
        CircleView(isOn: $isOn, hale: $hale, selected: $select, showInhale: $showInhale, showRetain: $showRetain, showExhale: $showExhale, showSustain: $showSustain, animation: $animation)
    }
}
