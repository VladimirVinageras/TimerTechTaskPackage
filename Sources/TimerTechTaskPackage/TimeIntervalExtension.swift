//
//  TimeIntervalExtension.swift
//  TechTask1
//
//  Created by Vladimir Vinakheras on 30.10.2024.
//

import Foundation

extension TimeInterval {

    func formattedTimeForTimerTask() -> String {
        let hours = Int(self) / 3600
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
    }
}
