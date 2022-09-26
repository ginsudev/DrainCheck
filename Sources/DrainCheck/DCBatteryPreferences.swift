//
//  DCBatteryPreferences.swift
//  
//
//  Created by Noah Little on 23/9/2022.
//

import Foundation

final class DCBatteryPreferences: NSObject {
    weak var manager: DCBatteryManager?
    
    init(manager: DCBatteryManager? = nil) {
        self.manager = manager
    }
    
    //MARK: - Data storage and retrieval
    //Enabled status
    public var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "DrainCheck.isEnabled")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "DrainCheck.isEnabled")
            manager?.log(start: newValue)
        }
    }
    
    //Start battery info
    public var start: [String : Any] {
        get {
            guard let dict = UserDefaults.standard.dictionary(forKey: "DrainCheck.startInfo") else {
                return [String : Any]()
            }
            
            return dict
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "DrainCheck.startInfo")
        }
    }
    
    //End battery info
    public var end: [String : Any] {
        get {
            guard let dict = UserDefaults.standard.dictionary(forKey: "DrainCheck.endInfo") else {
                return [String : String]()
            }
            
            return dict
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "DrainCheck.endInfo")
        }
    }
    
    public var startPercent: Int {
        return start["battery"] as? Int ?? 0
    }
    
    public var endPercent: Int {
        return end["battery"] as? Int ?? 0
    }
    
    public var startTime: Date {
        return start["time"] as? Date ?? Date()
    }
    
    public var endTime: Date {
        return end["time"] as? Date ?? Date()
    }
    
    public func writeLog(dict data: [String : Any]) {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        
        let plistURL = URL(fileURLWithPath: "/User/Library/Preferences/com.ginsu.draincheck.plist")

        guard let plistXML = try? Data(contentsOf: plistURL) else {
            return
        }
        
        guard var plistDict = try! PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String : Any] else {
            return
        }
        
        var logs = plistDict["logs"] as? [String : Any] ?? [String : Any]()
        logs[getSuitableKeyName(fromDate: data["saveDate"] as! Date)] = data
        plistDict["logs"] = logs
        
        do {
            let newData = try PropertyListSerialization.data(fromPropertyList: plistDict, format: propertyListFormat, options: 0)
            try newData.write(to: plistURL)
        } catch {
            NSLog("[DrainCheck]: \(error.localizedDescription)")
        }
    }
    
    private func getSuitableKeyName(fromDate date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmss"
        return formatter.string(from: date)
    }
}
