//
//  UIImageView+Extension.swift
//  DemoHyperhire
//
//  Created by CloudPark Infotech on 06/12/24.
//

import Foundation
import UIKit
import SDWebImage
import Photos

extension UIImageView {
    
    func loadImageFromProfile(urlString: String?, placeholderImage: UIImage? = nil){
        guard let themeURL = urlString, let imageURL = URL.init(string: themeURL) else {
            image = placeholderImage ?? UIImage(named: "img_PlaylistPH")
            return
        }
        
        sd_setImage(with: imageURL, placeholderImage: UIImage(named: "img_PlaylistPH"), options: .retryFailed) { (image, error, cacheType, url) in
            if image != nil{
                self.image = image
            }
            else {
                self.image = placeholderImage ?? UIImage()
            }
        }
    }
}
