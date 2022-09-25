//
//  DCDataHandler.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import Foundation
import SwiftUI

final class DataHandler: NSObject {
    private static let dictURL = URL(fileURLWithPath: "/var/mobile/Library/Preferences/com.ginsu.draincheck.plist")
    
    public static func fetchSortedLogs() -> [LogGroup]? {
        guard let logs = fetchTranslatedLogs() else {
            return [LogGroup]()
        }
        
        var sortedGroups = [LogGroup]()
        
        var currentDate = getFormattedDate(fromDate: logs.first!.saveDate)
        var groupToAdd = LogGroup(date: currentDate)
        
        logs.forEach {
            if currentDate == getFormattedDate(fromDate: $0.saveDate) {
                groupToAdd.logs.append($0)
            } else {
                sortedGroups.append(groupToAdd)
                
                currentDate = getFormattedDate(fromDate: $0.saveDate)
                groupToAdd = LogGroup(date: currentDate)
                groupToAdd.logs.append($0)
            }
        }
        
        sortedGroups.append(groupToAdd)
        return sortedGroups
    }
    
    private static func getFormattedDate(fromDate date: Date) -> String {
        let locale = Locale.current
        let dateTemplate = "yyyy/MM/dd"
        
        let localisedDateFormat = DateFormatter.dateFormat(fromTemplate: dateTemplate,
                                                           options: 0,
                                                           locale: locale)
        
        let formattedDate = DateFormatter()
        formattedDate.locale = locale
        formattedDate.timeZone = TimeZone.current
        formattedDate.dateFormat = localisedDateFormat
        
        return formattedDate.string(from: date)
    }
    
    public static func fetchTranslatedLogs() -> [Log]? {
        guard let logs = fetchDict(fromKey: "logs") else {
            return nil
        }
        
        var sortedKeys = [Int]()
        for key in logs.keys {
            if let numKey = Int(key) {
                sortedKeys.append(numKey)
            }
        }
        sortedKeys = Array(sortedKeys.sorted().reversed())

        var translatedLogs = [Log]()
        
        for numKey in sortedKeys {
            let key = "\(numKey)"
            
            let logDict = logs[key] as! [String : Any]
            
            let translatedLog = Log(startPercent: logDict["startPercent"] as! Int,
                                    endPercent: logDict["endPercent"] as! Int,
                                    startTime: logDict["startTime"] as! String,
                                    endTime: logDict["endTime"] as! String,
                                    batteryDiff: logDict["batteryDiff"] as! Int,
                                    timeDiff: logDict["timeDiff"] as! String,
                                    saveDate: logDict["saveDate"] as! Date)
            
            translatedLogs.append(translatedLog)
        }
        
        return translatedLogs
    }
    
    public static func fetchDict(fromKey key: String) -> [String : Any]? {
        if let prefsDict = prefsDict(), let dict = prefsDict[key] as? [String : Any] {
            guard !dict.isEmpty else {
                return nil
            }
            
            return dict
        }
        
        return nil
    }
    
    public static func removeLogs() {
        guard var logs = fetchDict(fromKey: "logs") else {
            return
        }
        
        logs.removeAll()
        writeDictToPrefs(dictionary: logs, key: "logs")
    }
    
    public static func writeDictToPrefs(dictionary dict: [String : Any], key: String) {
        guard var plistDict = prefsDict() else {
            return
        }
        
        let propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        
        plistDict[key] = dict
        
        do {
            let newData = try PropertyListSerialization.data(fromPropertyList: plistDict, format: propertyListFormat, options: 0)
            try newData.write(to: dictURL)
        } catch {
            return
        }
    }
    
    private static func prefsDict() -> [String : Any]? {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml

        guard let plistXML = try? Data(contentsOf: dictURL) else {
            return nil
        }
        
        guard let plistDict = try! PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String : AnyObject] else {
            return nil
        }
        
        return plistDict
    }
}
