//
//  DCBatteryManager.swift
//  
//
//  Created by Noah Little on 21/9/2022.
//

import DrainCheckC

final class DCBatteryManager: NSObject {
    public static let sharedInstance = DCBatteryManager()
    private var results: DCBatteryResults?
    private var preferences: DCBatteryPreferences?
    
    private override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRecieveStatusUpdateNotification(_:)),
                                               name: NSNotification.Name("DrainCheck.Notification.Enable"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRecieveStatusUpdateNotification(_:)),
                                               name: NSNotification.Name("DrainCheck.Notification.Disable"),
                                               object: nil)
        
        if Settings.automaticActivation == .lpm {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(didRecieveStatusUpdateNotification(_:)),
                                                   name: Notification.Name.NSProcessInfoPowerStateDidChange,
                                                   object: nil)
        }
        
        self.results = DCBatteryResults()
        self.preferences = DCBatteryPreferences(manager: self)
    }
    
    @objc private func didRecieveStatusUpdateNotification(_ notification: NSNotification) {
        var enabled: Bool {
            if notification.name.rawValue == "DrainCheck.Notification.Enable" {
                return true
            }
            
            if notification.name == Notification.Name.NSProcessInfoPowerStateDidChange {
                return ProcessInfo.processInfo.isLowPowerModeEnabled
            }
            
            return false
        }
        
        preferences?.isEnabled = enabled
        CCUIModuleInstanceManager.sharedInstance()._updateModuleInstances()
    }
    
    public func log(start isStart: Bool) {
        guard let results = results else {
            return
        }
        
        guard let preferences = preferences else {
            return
        }
        
        var dict = [String : Any]()
        dict["time"] = Date()
        dict["battery"] = results.batteryPercent
        
        if isStart {
            preferences.start = dict
        } else {
            preferences.end = dict
            presentBanner()
        }
    }
    
    private func presentBanner() {
        let startPercent = preferences!.startPercent
        let endPercent = preferences!.endPercent
        
        let startTime = results!.getFormattedTime(fromDate: preferences!.startTime)
        let endTime = results!.getFormattedTime(fromDate: preferences!.endTime)
        
        let batteryDiff = results!.getCalculatedBatteryDifference(start: startPercent, end: endPercent)
        let timeDiff = results!.getCalculatedTimeDifference(start: preferences!.startTime, end: preferences!.endTime)
        
        var msg: String {
            if endPercent < startPercent {
                return "Battery dropped from \(startPercent)% to \(endPercent)%, a total loss of \(batteryDiff)%."
            } else if endPercent > startPercent {
                return "Battery increased from \(startPercent)% to \(endPercent), a total gain of \(batteryDiff)%."
            } else {
                return "There was no drain during this time period."
            }
        }
        
        DCBatteryNotifier.notify(withTitle: "\(startTime) - \(endTime) (\(timeDiff))", message: msg)
        
        let data: [String : Any] = [
            "startPercent" : startPercent,
            "endPercent" : endPercent,
            "startTime" : startTime,
            "endTime" : endTime,
            "batteryDiff" : batteryDiff,
            "timeDiff" : timeDiff,
            "saveDate" : Date()
        ]
        
        preferences?.writeLog(dict: data)
    }
}
