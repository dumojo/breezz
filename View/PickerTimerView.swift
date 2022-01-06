//
//  PickerTimerView.swift
//  breezz
//
//  Created by Артем Дорожкин on 18.11.2021.
//

import SwiftUI

struct PickerTimerView: View {
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    var minutes = Array(0...59)
    var seconds = Array(0...59)
    
    @Binding var selectmin: Int
    @Binding var selectsec: Int
    @Binding var ShowTimerView: Bool
    @Binding var ShowTimer: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                   
                    .shadow(color: .gray, radius: 3)
                    .foregroundColor(Color(UIColor.systemGray6))
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(.init(gray: 255, alpha: 0)))
                    
                    
                VStack {
                    
                    HStack(spacing: 0) {
                        
                        Picker(selection: $selectmin, label: Text("")) {
                            ForEach(minutes, id: \.self) {i in
                                Text("\(self.minutes[i]) min").tag(i)
                            }
                        }
                            .pickerStyle(.wheel)
                            .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                            .compositingGroup()
                            .clipped()
                        
                        
                        Picker(selection: $selectsec, label: Text("")) {
                            ForEach(seconds, id: \.self) {i in
                                Text("\(seconds[i]) sec").tag(i)
                            }
                        }
                            .pickerStyle(.wheel)
                            .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                            .compositingGroup()
                            .clipped()
                       
                    }
                   
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                            Text("Apply")
                                .fontWeight(.light)
                        }
                        .frame(width: 100, height: 30.0)
                        .padding( .bottom, 10.0)
                        .onTapGesture {
                            ShowTimerView.toggle()
                            ShowTimer = true
                            selectionFeedbackGenerator.selectionChanged()
                        }
                    
                }
                
            }
            
        }
        .frame(width: 300, height: 250)
        
    }
}

struct PickerTimerView_Previews: PreviewProvider {
    @State static var selmin = 4
    @State static var selsec = 20
    
    @State static var Timerview = true
    static var previews: some View {
        PickerTimerView(selectmin: $selmin, selectsec: $selsec, ShowTimerView: $Timerview, ShowTimer: $Timerview)
    }
}
