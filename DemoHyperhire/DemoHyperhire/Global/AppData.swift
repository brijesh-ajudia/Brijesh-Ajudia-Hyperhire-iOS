//
//  AppData.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import Foundation

class AppData {
    
    //var userDetails: UserDetailsBody?
    var isLoginAsGuest: Bool = false
    var device_Token: String = ""
    var fcmToken: String = ""
    
    static let sharedInstance: AppData = {
        let instance = AppData()
        return instance
    }()
}
