//
//  modes.swift
//  breezz
//
//  Created by Артем Дорожкин on 12.12.2021.
//

import Foundation


struct Mode: Identifiable {
    let id: Int
    var name: String
    var image: String
    
    var Inhale: Double
    var Retain: Double
    var Exhale: Double
    var Sustain: Double
    
    var TotalTime: Double
    var TimeMin: Double
    var TimeSec: Double
    
    init(id: Int, name: String, image: String, Inhale: Double,Retain: Double, Exhale: Double,Sustain: Double, TotalTime: Double, TimeMin: Double, TimeSec: Double) {
            self.id = id
            self.name = name
            self.image = image
            self.Inhale = Inhale
            self.Retain = Retain
            self.Exhale = Exhale
            self.Sustain = Sustain
            self.TotalTime = TotalTime
            self.TimeMin = TimeMin
            self.TimeSec = TimeSec
        }
}

extension Mode{
    static var mode: [Mode] {
        [
            Mode(id:0,  name: "Clear Mind",  image: "brain.head.profile",   Inhale: 2, Retain: 0,   Exhale: 8,       Sustain: 0,   TotalTime: 423,  TimeMin: 7, TimeSec: 3),
            Mode(id:1,  name: "Relax",       image: "aqi.medium",           Inhale: 2, Retain: 0,   Exhale: 5,       Sustain: 5,   TotalTime: 423,  TimeMin: 7, TimeSec: 3),
            Mode(id:2,  name: "Power",       image: "bolt",                 Inhale: 2, Retain: 5,   Exhale: 5,       Sustain: 0,   TotalTime: 423,  TimeMin: 7, TimeSec: 3),
            Mode(id:3,  name: "Anti-Stress", image: "bolt.shield",          Inhale: 8, Retain: 0,   Exhale: 0.98,    Sustain: 0,   TotalTime: 223,  TimeMin: 3, TimeSec: 43)
        ]
    }
}
