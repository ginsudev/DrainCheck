import Orion
import DrainCheckC
import Foundation

struct Main: HookGroup {}
struct DND: HookGroup {}

class SpringBoard_Hook: ClassHook<UIApplication> {
    typealias Group = Main
    static var targetName: String = "SpringBoard"

    func applicationDidFinishLaunching(_ application: AnyObject?) {
        orig.applicationDidFinishLaunching(application)
        //Instantiate DrainCheck manager's shared instance, so we can recieve notifications.
        let _ = DCBatteryManager.sharedInstance
    }
}

class DNDNotificationsService_Hook: ClassHook<DNDNotificationsService> {
    typealias Group = DND
    
    func stateService(_ arg1: AnyObject, didReceiveDoNotDisturbStateUpdate update: DNDStateUpdate) {
        orig.stateService(arg1, didReceiveDoNotDisturbStateUpdate: update)
        
        if update.state.isActive {
            NotificationCenter.default.post(name: NSNotification.Name("DrainCheck.Notification.Enable"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name("DrainCheck.Notification.Disable"), object: nil)
        }
    }
}

//MARK: - Preferences
fileprivate func prefsDict() -> [String : Any]? {
    var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
    
    let path = "/var/mobile/Library/Preferences/com.ginsu.draincheck.plist"
    
    if !FileManager().fileExists(atPath: path) {
        try? FileManager().copyItem(atPath: "Library/PreferenceBundles/draincheck.bundle/defaults.plist",
                                    toPath: path)
    }
    
    let plistURL = URL(fileURLWithPath: path)

    guard let plistXML = try? Data(contentsOf: plistURL) else {
        return nil
    }
    
    guard let plistDict = try! PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String : Any] else {
        return nil
    }
    
    return plistDict
}

fileprivate func readPrefs() {
    
    let dict = prefsDict() ?? [String : Any]()
    
    //Reading values
    Settings.isEnabled = dict["isEnabled"] as? Bool ?? true
    Settings.automaticActivation = AutomaticActivationType(rawValue: dict["autoActivation"] as? Int ?? 0)
}

struct DrainCheck: Tweak {
    init() {
        readPrefs()
        if (Settings.isEnabled) {
            Main().activate()
            
            if Settings.automaticActivation == .dnd {
                DND().activate()
            }
        }
    }
}
