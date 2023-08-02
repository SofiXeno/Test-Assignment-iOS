//
//  CardDetailsViewController.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import UIKit
import SnapKit

final class CardDetailsViewController: UIViewControllerWithCoordinatorAndParams {

    
    // MARK: - Properties
    private lazy var cardTypeImg : UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    private lazy var bankLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Bank"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        lbl.numberOfLines = 3
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var cardView : UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cardNumberLabel : UILabel = {
        var lbl = UILabel()
        lbl.textColor = .systemGray
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        lbl.numberOfLines = 3
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpNavBarBackBtn(text: "SSSSS")
        self.view.backgroundColor = .white
        
        self.configVCFromCardModel()
        
        self.view.addSubview(self.cardView)
        self.cardView.addSubview(self.bankLabel)
        self.cardView.addSubview(self.cardNumberLabel)
        self.cardView.addSubview(self.cardTypeImg)
        
        self.setUpLayout()
    }

    override func viewWillLayoutSubviews() {
      

        print(#function)
        //self.cardView.snp.removeConstraints()
        self.cardView.snp.remakeConstraints {
            
            
            
            if  UIDevice.current.orientation.isLandscape {
                
           
               // $0.height.equalToSuperview().multipliedBy(0.7)
                $0.leading.lessThanOrEqualToSuperview().offset(UIScreen.main.bounds.height < 390 ? 100 : 250)
                $0.trailing.lessThanOrEqualToSuperview().inset(UIScreen.main.bounds.height < 390 ? 100 : 250)
                $0.height.equalToSuperview().multipliedBy(0.65)

            }
            else{
               // $0.height.equalToSuperview().multipliedBy(0.3)
                $0.leading.greaterThanOrEqualToSuperview().offset(20)
                $0.trailing.greaterThanOrEqualToSuperview().inset(20)
                $0.height.equalToSuperview().multipliedBy(0.3)

            }
            
            
           

            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
  
            // $0.width.equalTo(self.cardView.snp.height).multipliedBy(1.5)
     
            
            }
        }


    }


// MARK: - set up UI extension
extension CardDetailsViewController{
    
    func configVCFromCardModel(){
        guard let params = self.params, let card = params["card"] as? CardModel, let maskedNumb = card.maskCardNumberForTable(), let type = card.cardType else {return}
   
      
        self.cardNumberLabel.text = String(maskedNumb.suffix(9))
        self.cardTypeImg.image = type.image
        self.cardView.backgroundColor = UIColor(rgb: type.hexColor)
        
      
    }
    
    func setUpLayout(){
     
        self.cardView.snp.makeConstraints {
            // centered X and Y
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)

            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20)

            
         //   $0.width.equalTo(self.cardView.snp.height).multipliedBy(1.5)
    
            $0.height.equalToSuperview().multipliedBy(0.3)
    
        }
        
        self.cardTypeImg.snp.makeConstraints{
            $0.trailing.lessThanOrEqualToSuperview().inset(15)
            $0.bottom.greaterThanOrEqualToSuperview().inset(10)
            $0.width.equalTo(self.cardTypeImg.snp.height).multipliedBy(9/5)
            $0.height.equalTo(50)
            
        }
        
        self.cardNumberLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.cardTypeImg.snp.centerY)
           // $0.trailing.equalTo(self.cardTypeImg.snp.leading).inset(-5)
            $0.height.equalTo(50)
            $0.leading.lessThanOrEqualToSuperview().offset(15)
        }
  
        
        self.bankLabel.snp.makeConstraints{
           
            $0.bottom.lessThanOrEqualTo(self.cardNumberLabel.snp.top).offset(10)
            $0.top.lessThanOrEqualToSuperview().offset(30)
            $0.height.equalTo(50)
            $0.leading.lessThanOrEqualToSuperview().offset(15)
        }
    }
}
