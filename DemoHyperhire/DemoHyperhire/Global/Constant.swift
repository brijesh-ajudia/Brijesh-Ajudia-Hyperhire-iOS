//
//  Constant.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import Foundation
import UIKit

let App_Name = "Demo Hyperhire"

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
let sceneDelegate = windowScene?.delegate as? SceneDelegate
 
let screenSize = UIScreen.main.bounds.size


struct StoryBoard {
    static let SB_MAIN = "Main"
    
    static let SB_HOME = "Home"
    static let SB_SEARCH = "Search"
    static let SB_LIBRARY = "Library"
    
}

struct ViewControllerID {
    static let VC_Home = "HomeVC"
    static let VC_Search = "SearchVC"
    
    static let VC_YourLibrary = "YourLibraryVC"
}

struct AppFont {
    enum FontType: String {
        case Bold = "AvenirNext-Bold"
        case DemiBold = "AvenirNext-DemiBold"
        case Medium = "AvenirNext-Medium"
        case Regular = "AvenirNext-Regular"
        case ULight = "AvenirNext-UltraLight"
    }
    static func font(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}
