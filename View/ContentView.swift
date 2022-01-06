//
//  ContentView.swift
//  breezz
//
//  Created by Артем Дорожкин on 08.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var showMainView:Bool = false
   
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()
    let haptic = UIImpactFeedbackGenerator()
    
    var minutes = Array(0...59)
    var seconds = Array(0...59)
    
    @State var selected: Int = 1
    @State var isOn: Bool = false
    @State var ShowTimer: Bool = false
    @State var ShowTimerView: Bool = false
    @State var hale: Bool = false
   
    @State var selectedMins:Int = 7
    @State var selectedSecs:Int = 3
    @State private var timer: Timer?
    
    @State var tain: Bool = false
    @State var tain1: Bool = false
    
    @State var showInhale: Bool = true
    @State var showRetain: Bool = false
    @State var showExhale: Bool = false
    @State var showSustain: Bool = false
    
    @State var timeInhale = 0.0
    @State var timeRetain = 0.0
    @State var timeExhale = 0.0
    @State var timeSustain = 0.0
    
    @State var animation: Animation = Animation.easeOut(duration: 3).delay(3).repeatForever(autoreverses: true)
    
    
    
    var body: some View {
        
        
        
        ZStack {
            if self.showMainView{
                VStack {
                    ZStack {
                        HStack{
                               Text("\((calculate() / 60) % 60,specifier: "%02d") :")
                                .font(.largeTitle)
                                .fontWeight(.thin)
                               
                               Text("\(calculate() % 60,specifier: "%02d")")
                                   .font(.largeTitle)
                                   .fontWeight(.thin)
                        }.opacity(ShowTimer ? 1:0).animation(.easeOut)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke()
                            Text("Timer")
                                .font(.title2)
                                .fontWeight(.thin)
                        }
                        .frame(width: 150.0, height: 40.0)
                        .opacity(ShowTimer ? 0:1).animation(.easeOut)
                        
                    }
                    .onTapGesture {
                        ShowTimerView.toggle()
                        selectionFeedbackGenerator.selectionChanged()
                    }
                    
                    Spacer()
                    ZStack {
                        CircleView(isOn: $isOn, hale: $hale, selected: $selected, showInhale: $showInhale, showRetain: $showRetain, showExhale: $showExhale, showSustain: $showSustain, animation: $animation)
                            .onTapGesture {
                                isOn.toggle()
                                isOn ? startTimer():stopTimer()
                                haptic.impactOccurred()
                                print("haptic inpact")
                                print("IsOn :",isOn)
                            }
                        VStack {
                            PickerTimerView(selectmin: $selectedMins, selectsec: $selectedSecs, ShowTimerView: $ShowTimerView, ShowTimer: $ShowTimer)
                                .opacity(ShowTimerView ? 1:0).animation(.easeOut)
                            Spacer()
                        }
                    }
                    Spacer()
                    
                }
                VStack {
                    Spacer()
                    PickerView(selected: $selected, isOn: $isOn)
                        .padding(.horizontal)
                        .onChange(of: selected) { _ in
                            stopTimer()
                            ShowTimer = true
                            
                        }
                }
            }else
            {
                SplashView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.showMainView = true
                        }
                    }
                }
    }
    
    func calculate() -> Int {
       let totalsecs = self.selectedSecs + self.selectedMins*60
       return totalsecs
    }
    func startTimer(){
        print("Start Timer")
        self.showInhale = false
        self.showSustain = false
        self.showRetain = false
        self.showExhale = false
        self.hale = false
        self.tain = false
        self.tain1 = false
        timeInhale = Mode.mode[selected].Inhale
        timeRetain = Mode.mode[selected].Retain
        timeExhale = Mode.mode[selected].Exhale
        timeSustain = Mode.mode[selected].Sustain
        
        if self.calculate() <= 0 {
            self.ShowTimer = true
            selectedSecs = Int(Mode.mode[selected].TimeSec)
            selectedMins = Int(Mode.mode[selected].TimeMin)
            startTimer()
            
        }else{
            self.ShowTimer = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                var secs = self.calculate()
                secs -= 1
                
                if (isOn == true) {
                    if hale{
                        if tain{
                            if timeSustain > 0{
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    timeSustain -= 1
                                    print("Sustain: ",timeSustain)
                                animation = Animation.easeOut(duration: Mode.mode[selected].Sustain)
                                    showInhale = false
                                    showRetain = false
                                    showExhale = false
                                    showSustain = true
                            }else{
                                tain.toggle()
                                hale.toggle()
                                timeExhale = Mode.mode[selected].Exhale
                                timeSustain = Mode.mode[selected].Sustain
                                if showSustain{notification.notificationOccurred(.success)}
                            }
                            
                        }else{
                            
                            if timeExhale > 0{
                                timeExhale -= 1
                                print("Exhale: ",timeExhale)
                                animation = Animation.easeOut(duration: Mode.mode[selected].Exhale)
                                showInhale = false
                                showRetain = false
                                showExhale = true
                                showSustain = false
                            }else{
                                tain.toggle()
                                if showExhale{notification.notificationOccurred(.success)}
                            }
                        }
                    
                    }else{
                        if tain1{
                            if timeRetain > 0{
                                let impactLight = UIImpactFeedbackGenerator(style: .light)
                                impactLight.impactOccurred()
                                timeRetain -= 1
                                print("Retain: ",timeRetain)
                                animation = Animation.easeOut(duration: Mode.mode[selected].Retain)
                                showInhale = false
                                showRetain = true
                                showExhale = false
                                showSustain = false
                            }else{
                                tain1.toggle()
                                hale.toggle()
                                timeRetain = Mode.mode[selected].Retain
                                timeInhale = Mode.mode[selected].Inhale
                                if showRetain{notification.notificationOccurred(.success)}
                            }
                        }else{
                        
                            if timeInhale > 0{
                                timeInhale -= 1
                                print("Inhale: ",timeInhale)
                                animation = Animation.easeOut(duration: Mode.mode[selected].Inhale)
                                showInhale = true
                                showRetain = false
                                showExhale = false
                                showSustain = false
                            }else{
                                tain1.toggle()
                                if showInhale{notification.notificationOccurred(.success)}
                            }
                        }
                        
                    }
                    
                }
                if self.calculate() <= 0 {
                    self.hale = false
                    self.tain = false
                    self.tain1 = false
                    self.timer?.invalidate()
                    self.selectedSecs = 0
                    self.selectedMins = 0
                    self.isOn = false
                    self.ShowTimer = false
                    self.showInhale = false
                    self.showSustain = false
                    self.showRetain = false
                    self.showExhale = false
                    timeInhale = Mode.mode[selected].Inhale
                    timeRetain = Mode.mode[selected].Retain
                    timeExhale = Mode.mode[selected].Exhale
                    timeSustain = Mode.mode[selected].Sustain
                    print("Stop Timer")
                }
                
                self.selectedSecs = secs % 60
                self.selectedMins = (secs/60) % 60
                print("Timer ",selectedMins,":",selectedSecs)
            }
        }
    }
    func stopTimer(){
        self.hale = false
        self.tain = false
        self.tain1 = false
        self.timer?.invalidate()
        self.selectedMins = 0
        self.selectedSecs = 0
        self.isOn = false
        self.ShowTimer = false
        self.showInhale = false
        self.showSustain = false
        self.showRetain = false
        self.showExhale = false
        timeInhale = Mode.mode[selected].Inhale
        timeRetain = Mode.mode[selected].Retain
        timeExhale = Mode.mode[selected].Exhale
        timeSustain = Mode.mode[selected].Sustain
        print("Stop Timer")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
