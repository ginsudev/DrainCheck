//
//  DCDataHandler.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import Foundation
import SwiftUI

enum DateFormatType: String
{
    case timeWithSeconds = "h:mm:ss a",
         time = "h:mm a",
         date = "yyyy/MM/dd",
         dateKeyFormat = "yyyyMMddHHmmss"
}

final class DataHandler: NSObject
{
    private static let dictURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.ginsu.draincheck.plist")
    
    public static func fetchSortedLogs() -> [LogGroup]?
    {
        guard let logs = fetchTranslatedLogs() else
        {
            return [LogGroup]()
        }
        
        var sortedGroups = [LogGroup]()
        
        var currentDate = getFormattedDate(fromDate: logs.first!.saveDate, withFormatType: .date, localised: true)
        var groupToAdd = LogGroup(date: currentDate)
        
        logs.forEach
        {
            if currentDate == getFormattedDate(fromDate: $0.saveDate, withFormatType: .date, localised: true)
            {
                groupToAdd.logs.append($0)
            }
            else
            {
                sortedGroups.append(groupToAdd)
                
                currentDate = getFormattedDate(fromDate: $0.saveDate, withFormatType: .date, localised: true)
                groupToAdd = LogGroup(date: currentDate)
                groupToAdd.logs.append($0)
            }
        }
        
        sortedGroups.append(groupToAdd)
        return sortedGroups
    }
        
    public static func getFormattedDate(fromDate date: Date, withFormatType type: DateFormatType, localised: Bool) -> String
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
    
    public static func fetchTranslatedLogs() -> [Log]?
    {
        guard let logs = fetchDict(fromKey: "logs") else
        {
            return nil
        }
        
        var sortedKeys = [Int]()
        for key in logs.keys
        {
            if let numKey = Int(key)
            {
                sortedKeys.append(numKey)
            }
        }
        sortedKeys = Array(sortedKeys.sorted().reversed())

        var translatedLogs = [Log]()
        
        for numKey in sortedKeys
        {
            let key = "\(numKey)"
            
            let logDict = logs[key] as! [String : Any?]
            
            if let translatedLog = safelyGenerateLog(withLogDict: logDict)
            {
                translatedLogs.append(translatedLog)
            }
            else
            {
                removeLog(withKey: getFormattedDate(fromDate: logDict["saveDate"] as! Date,
                                                    withFormatType: .dateKeyFormat,
                                                    localised: false))
            }
            
        }
        
        return translatedLogs
    }
    
    private static func safelyGenerateLog(withLogDict logDict: [String : Any?]) -> Log?
    {
        guard let startPercent = logDict["startPercent"] as? Int else
        {
            return nil
        }
        
        guard let endPercent = logDict["endPercent"] as? Int else
        {
            return nil
        }
        
        guard let batteryDiff = logDict["batteryDiff"] as? Int else
        {
            return nil
        }
        
        guard let timeDiff = logDict["timeDiff"] as? String else
        {
            return nil
        }
        
        guard let saveDate = logDict["saveDate"] as? Date else
        {
            return nil
        }
        
        guard let startDate = logDict["startDate"] as? Date else
        {
            return nil
        }
        
        return Log(startPercent: startPercent,
                   endPercent: endPercent,
                   batteryDiff: batteryDiff,
                   timeDiff: timeDiff,
                   saveDate: saveDate,
                   startDate: startDate)
    }
    
    public static func fetchDict(fromKey key: String) -> [String : Any]?
    {
        if let prefsDict = prefsDict(), let dict = prefsDict[key] as? [String : Any]
        {
            guard !dict.isEmpty else
            {
                return nil
            }
            
            return dict
        }
        
        return nil
    }
    
    public static func getKey(forLog log: Log) -> String
    {
        return getFormattedDate(fromDate: log.saveDate, withFormatType: .dateKeyFormat, localised: false)
    }
    
    public static func removeLogs()
    {
        guard var logs = fetchDict(fromKey: "logs") else
        {
            return
        }
        
        logs.removeAll()
        writeDictToPrefs(dictionary: logs, key: "logs")
    }
    
    public static func removeLog(withKey key: String)
    {
        guard var logs = fetchDict(fromKey: "logs") else
        {
            return
        }
        
        logs.removeValue(forKey: key)
        writeDictToPrefs(dictionary: logs, key: "logs")
    }
    
    public static func writeDictToPrefs(dictionary dict: [String : Any], key: String)
    {
        guard var plistDict = prefsDict() else
        {
            return
        }
        
        let propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        
        plistDict[key] = dict
        
        do
        {
            let newData = try PropertyListSerialization.data(fromPropertyList: plistDict, format: propertyListFormat, options: 0)
            try newData.write(to: dictURL)
        }
        catch
        {
            return
        }
    }
    
    private static func prefsDict() -> [String : Any]?
    {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml

        guard let plistXML = try? Data(contentsOf: dictURL) else
        {
            return nil
        }
        
        guard let plistDict = try! PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String : AnyObject] else
        {
            return nil
        }
        
        return plistDict
    }
}
