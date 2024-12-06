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


class DictionaryEncoder {
    
    private let encoder = JSONEncoder()
    
    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        set { encoder.dateEncodingStrategy = newValue }
        get { return encoder.dateEncodingStrategy }
    }
    
    var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy {
        set { encoder.dataEncodingStrategy = newValue }
        get { return encoder.dataEncodingStrategy }
    }
    
    var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy {
        set { encoder.nonConformingFloatEncodingStrategy = newValue }
        get { return encoder.nonConformingFloatEncodingStrategy }
    }
    
    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        set { encoder.keyEncodingStrategy = newValue }
        get { return encoder.keyEncodingStrategy }
    }
    
    func encode<T>(_ value: T) throws -> [String: Any] where T : Encodable {
        let data = try encoder.encode(value)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

class DictionaryDecoder {
    
    private let decoder = JSONDecoder()
    
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        set { decoder.dateDecodingStrategy = newValue }
        get { return decoder.dateDecodingStrategy }
    }
    
    var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy {
        set { decoder.dataDecodingStrategy = newValue }
        get { return decoder.dataDecodingStrategy }
    }
    
    var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy {
        set { decoder.nonConformingFloatDecodingStrategy = newValue }
        get { return decoder.nonConformingFloatDecodingStrategy }
    }
    
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
        set { decoder.keyDecodingStrategy = newValue }
        get { return decoder.keyDecodingStrategy }
    }
    
    func decode<T>(_ type: T.Type, from dictionary: [String: Any]) throws -> T where T : Decodable {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try decoder.decode(type, from: data)
    }
}
