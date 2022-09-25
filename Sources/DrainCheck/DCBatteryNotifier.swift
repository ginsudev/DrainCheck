//
//  DCBatteryNotifier.swift
//  
//
//  Created by Noah Little on 23/9/2022.
//

import DrainCheckC

final class DCBatteryNotifier: NSObject {
    
    public static func notify(withTitle title: String, message msg: String) {
        guard let handle = dlopen("/usr/lib/libnotifications.dylib", RTLD_LAZY) else {
            return
        }
        
        let uuid = NSUUID().uuidString
        
        _CPNotification.showAlert(withTitle: title,
                                 message: msg,
                                 userInfo: ["": ""],
                                 badgeCount: 0,
                                 soundName: nil,
                                 delay: 1.00,
                                 repeats: false,
                                 bundleId: "com.ginsu.DrainCheck",
                                 uuid: uuid,
                                 silent: false)
        
        dlclose(handle)
    }
}
