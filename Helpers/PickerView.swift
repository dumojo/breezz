//
//  PickerView.swift
//  breezz
//
//  Created by Артем Дорожкин on 15.11.2021.
//

import SwiftUI

struct PickerView: View {
    
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    
    @Binding var selected: Int
    @Binding var isOn: Bool
    
    var body: some View {
       
        VStack {
            Text(Mode.mode[selected].name)
                .fontWeight(.thin)
                .padding(.bottom, 1.0)
            Picker(selection: $selected, label: Text("Picker")) {
                ForEach(Mode.mode){ mode in
                    Image(systemName: mode.image).tag(mode.id)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 1.0)
                .onChange(of: selected) { newValue in
                    isOn = false
                    print("change :",Mode.mode[selected].name)
                    selectionFeedbackGenerator.selectionChanged()
            }
        }
                
           
            
    }
}

struct PickerView_Previews: PreviewProvider {
    @State static var selected = 2
    @State static var on = false
    static var previews: some View {
        PickerView(selected: $selected, isOn: $on)
    }
}
