//
//  DCBatteryResults.swift
//  
//
//  Created by Noah Little on 23/9/2022.
//

import UIKit

enum DateFormatType: String
{
    case timeWithSeconds = "h:mm:ss a",
         time = "h:mm a",
         date = "yyyy/MM/dd",
         dateKeyFormat = "yyyyMMddHHmmss"
}

final class DCBatteryResults: NSObject
{
    public var batteryPercent: Int
    {
        get
        {
            return Int(UIDevice.current.batteryLevel * 100)
        }
    }
    
    public func getCalculatedBatteryDifference(start startPercent: Int, end endPercent: Int) -> Int
    {
        return abs(startPercent - endPercent)
    }
    
    public func getCalculatedTimeDifference(start startTime: Date, end endTime: Date) -> String
    {
        let totalSeconds = Int(endTime.timeIntervalSince(startTime))
        
        var seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3600
        
        seconds = seconds <= 0 ? 0 : seconds
        
        guard hours <= 0 else
        {
            return String(format: "%02d:%02d:%02d", arguments: [hours, minutes, seconds])
        }
        
        return String(format: "%02d:%02d", arguments: [minutes, seconds])
    }
    
    public func getFormattedDate(fromDate date: Date, withFormatType type: DateFormatType, localised: Bool) -> String
    {
        let dateTemplate = type.rawValue
        let formattedDate = DateFormatter()

        if localised
        {
            let localisedDateFormat = DateFormatter.dateFormat(fromTemplate: dateTemplate, options: 0, locale: Locale.current)
            formattedDate.locale = Locale.current
            formattedDate.timeZone = TimeZone.current
            formattedDate.dateFormat = localisedDateFormat
        }
        else
        {
            formattedDate.dateFormat = dateTemplate
        }

        return formattedDate.string(from: date)
    }
}
