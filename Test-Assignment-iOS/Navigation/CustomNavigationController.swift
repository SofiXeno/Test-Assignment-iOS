//
//  CustomNavigationController.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import UIKit

final class CustomNavigationController: UINavigationController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
 
}

extension CustomNavigationController {
    
    
    //MARK: - for status bar
    func configure(){
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = .none
            appearance.shadowImage = UIImage()

            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.compactAppearance = appearance
        } else {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().isTranslucent = true
        }
      

        self.navigationBar.frame.size = self.navigationBar.sizeThatFits(CGSize(width: self.navigationBar.frame.size.width, height: 55))
        
    }
    
    //MARK: - for status bar
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    
}
