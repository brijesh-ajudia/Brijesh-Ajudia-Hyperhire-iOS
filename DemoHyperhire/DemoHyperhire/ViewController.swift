//
//  ViewController.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let font: UIFont = AppFont.font(type: .Regular, size: 11)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        self.setUpViewControllers()
    }

    // MARK: - Set Up View Controllers
    func setUpViewControllers() {
        let controller1 = Utils.loadVC(strStoryboardId: StoryBoard.SB_HOME, strVCId: ViewControllerID.VC_Home) as! HomeVC
        controller1.view.backgroundColor = ._121212
        controller1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icn_Home"), selectedImage: UIImage(named: "icn_Home"))
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if DeviceUtility.deviceHasTopNotch == true {
                controller1.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
            }
            else {
                controller1.tabBarItem.imageInsets = UIEdgeInsets(top: -19, left: 0, bottom: 0, right: 0)
            }
        case .pad:
            controller1.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
        default:
            controller1.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        }
        
        let nav1 = UINavigationController(rootViewController: controller1)
        nav1.isNavigationBarHidden = true
        nav1.title = ""
        
        let controller2 = Utils.loadVC(strStoryboardId: StoryBoard.SB_SEARCH, strVCId: ViewControllerID.VC_Search) as! SearchVC
        controller2.view.backgroundColor = ._121212
        controller2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "icn_Search"), selectedImage: UIImage(named: "icn_Search"))
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if DeviceUtility.deviceHasTopNotch == true {
                controller2.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
            }
            else {
                controller2.tabBarItem.imageInsets = UIEdgeInsets(top: -19, left: 0, bottom: 0, right: 0)
            }
        case .pad:
            controller2.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
        default:
            controller2.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        }
        let nav2 = UINavigationController(rootViewController: controller2)
        nav2.isNavigationBarHidden = true
        nav2.title = ""
        
        let controller3 = Utils.loadVC(strStoryboardId: StoryBoard.SB_LIBRARY, strVCId: ViewControllerID.VC_YourLibrary) as! YourLibraryVC
        controller3.view.backgroundColor = ._121212
        controller3.tabBarItem = UITabBarItem(title: "Your Library", image: UIImage(named: "icn_Library"), selectedImage: UIImage(named: "icn_Library"))
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            if DeviceUtility.deviceHasTopNotch == true {
                controller3.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
            }
            else {
                controller3.tabBarItem.imageInsets = UIEdgeInsets(top: -19, left: 0, bottom: 0, right: 0)
            }
        case .pad:
            controller3.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
        default:
            controller3.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        }
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.isNavigationBarHidden = true
        nav3.title = ""
        
        viewControllers = [nav1, nav2, nav3]
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if traitCollection.userInterfaceStyle == .light || traitCollection.userInterfaceStyle == .dark {
            self.tabBar.backgroundColor = ._121212
            self.tabBar.unselectedItemTintColor = .B_3_B_3_B_3
            self.tabBar.tintColor = .white
        }
    }

}

