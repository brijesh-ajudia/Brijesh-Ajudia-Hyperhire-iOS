//
//  Utils.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import Foundation
import UIKit

class Utils {
    
    static let sharedInstance: Utils = {
        let instance = Utils()
        return instance
    }()
    
    class func loadVC(strStoryboardId: String, strVCId: String) -> UIViewController {
        let vc = getStoryboard(storyboardName: strStoryboardId).instantiateViewController(withIdentifier: strVCId)
        return vc
    }
    
    class func getStoryboard(storyboardName: String) -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
    
}


class DeviceUtility {
    static var deviceHasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return sceneDelegate?.window?.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

public func screenWidth() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    return screenSize.width
}

public func screenHeight() -> CGFloat {
    let screenSize = UIScreen.main.bounds
    return screenSize.height
}
