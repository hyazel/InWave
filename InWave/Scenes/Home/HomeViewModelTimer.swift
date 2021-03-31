//
//  HomeViewModelTimer.swift
//  InWave
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

final class HomeViewModelTimer: ObservableObject {
    @Published var time: String = ""
    
    init() {
        time = getTime()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.time = self.getTime()
        }
    }
    
    func getTime() -> String {
        let date = Date()

        // *** create calendar object ***
        let calendar = Calendar.current
        
        // *** Get Individual components from date ***
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return (hour < 10 ? "0\(hour)" : "\(hour)") + ":" + (minutes < 10 ? "0\(minutes)" : "\(minutes)")
    }
}
