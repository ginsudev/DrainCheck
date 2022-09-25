//
//  DCBatteryResults.swift
//  
//
//  Created by Noah Little on 23/9/2022.
//

import UIKit

final class DCBatteryResults: NSObject {
    public var batteryPercent: Int {
        get {
            return Int(UIDevice.current.batteryLevel * 100)
        }
    }
    
    public func getCalculatedBatteryDifference(start startPercent: Int, end endPercent: Int) -> Int {
        return abs(startPercent - endPercent)
    }
    
    public func getCalculatedTimeDifference(start startTime: Date, end endTime: Date) -> String {
        let totalSeconds = Int(endTime.timeIntervalSince(startTime))
        
        var seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3600
        
        seconds = seconds <= 0 ? 0 : seconds
        
        guard hours <= 0 else {
            return String(format: "%02d:%02d:%02d", arguments: [hours, minutes, seconds])
        }
        
        return String(format: "%02d:%02d", arguments: [minutes, seconds])
    }
    
    public func getFormattedTime(fromDate date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
