//
//  CardDetailsViewController.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import UIKit

class CardDetailsViewController: UIViewControllerWithCoordinatorAndParams {

    
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
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .regular)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.cardView)
        self.cardView.addSubview(self.bankLabel)
        self.cardView.addSubview(self.cardNumberLabel)
        self.cardView.addSubview(self.cardTypeImg)
        
        self.configVCFromCardModel()
        self.setUpLayout()
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
        
        
        let maxWidthContainer: CGFloat = 394
          let maxHeightContainer: CGFloat = 256
        
        self.cardView.snp.makeConstraints { (make) in
            // centered X and Y
            make.centerX.centerY.equalToSuperview()

            // at least 38 points "padding" on all 4 sides

            // leading and top >= 38
            make.leading.greaterThanOrEqualTo(10)

            // trailing and bottom <= 38
            make.trailing.lessThanOrEqualTo(10)

            // width ratio to height
            make.width.equalTo(self.cardView.snp.height).multipliedBy(maxWidthContainer/maxHeightContainer)

            // max height
            make.height.lessThanOrEqualTo(maxHeightContainer)
        }
        
        self.cardTypeImg.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(90)
            
            $0.height.equalTo(50)
            
        }
        
        self.cardNumberLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.cardTypeImg.snp.centerY)
            $0.trailing.equalToSuperview().inset(5)
            $0.leading.equalTo(self.cardTypeImg.snp.trailing).offset(10)
        }
  
    }
}
