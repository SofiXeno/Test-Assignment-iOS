//
//  UINavigationBar + style.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize { CGSize(width: self.frame.size.width, height: size.height) }
}
