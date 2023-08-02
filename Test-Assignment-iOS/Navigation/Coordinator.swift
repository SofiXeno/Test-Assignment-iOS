//
//  Coordinator.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import UIKit
import SnapKit


protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func openVCWithoutStoryboard(type: (ControllerHasCoordinator & UIViewController).Type)
    func openVCWithoutStoryboardWithParams(type: UIViewControllerWithCoordinatorAndParams.Type, params: [String : Any])

    func goBack()
    
}

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
 
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }

    func openVCWithoutStoryboard(type: (UIViewController & ControllerHasCoordinator).Type) {
        var vc = type.init()
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func openVCWithoutStoryboardWithParams(type: UIViewControllerWithCoordinatorAndParams.Type, params: [String : Any]) {
        let vc = type.init()
        vc.modalPresentationStyle = .fullScreen
        vc.coordinator = self
        vc.params = params
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

//MARK: - UIViewController with coordinator
protocol ControllerHasCoordinator {
    var coordinator : AppCoordinator? {get set}
}

class UIViewControllerWithCoordinator : UIViewController, ControllerHasCoordinator {
    weak var coordinator : AppCoordinator?
}

//MARK: - UIViewController with coordinator and params
class UIViewControllerWithCoordinatorAndParams : UIViewControllerWithCoordinator, ControllerHasParams {
    var params: [String : Any]?
}

protocol ControllerHasParams {
    var params : [String:Any]? {get set}
}

//MARK: - UIViewControllerWithCoordinator
extension UIViewControllerWithCoordinator {
    
    @objc func goBack(){
        guard let coordinator = self.coordinator else { return }
        coordinator.goBack()
    }
    
    func setUpNavBarBackBtn(text: String){
 
        let backItem = UIBarButtonItem(title: text, style: .plain, target: nil, action: #selector(self.goBack))
        self.navigationItem.backBarButtonItem = backItem
 
    }
    
    func setUpRightNavBarItem(menuBtn: UIButton, selector: Selector){
   
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 50, height: 50)
        menuBtn.addTarget(self, action: selector, for: .touchUpInside)
    
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.rightBarButtonItem = menuBarItem
        
        
    }
    
    func setUpNavigationTitle(text: String){
        
        let titleView = UIView()
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.text = text
        self.navigationItem.title = text

        titleView.addSubview(label)

        label.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        self.navigationItem.titleView = titleView

    }
    
    
}
