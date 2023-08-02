//
//  MainCardsTableViewCell.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import UIKit

final class MainCardsTableViewCell: UITableViewCell {

    static let nib = "MainCardsTableViewCell"
    static let reuseIdentifier = "MainCardsTableViewCellIdentifier"
    
    // MARK: - Properties
    private lazy var cardTypeImg : UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    private lazy var backView : UIView = {
        var view = UIView()
        view.backgroundColor = .clear

        return view
    }()
    
    private lazy var cardNumberLabel : UILabel = {
        var lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        lbl.numberOfLines = 3
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()

    override var isSelected: Bool {
        didSet {
            self.backView.backgroundColor = isSelected ? .lightGray : .clear
        }
    }
    
    // MARK: - inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        self.addSubview(self.backView)
        self.backView.addSubview(self.cardTypeImg)
        self.backView.addSubview(self.cardNumberLabel)
        
        
        self.setUpLayout()
        
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    // MARK: - configure cell
    func config(card: CardModel){
        
        guard let type = card.cardType, let maskedCardNumb = card.maskCardNumberForTable() else {return}
        self.cardTypeImg.image = type.image
        self.cardNumberLabel.text = maskedCardNumb
        
    }
    
}

// MARK: - set up UI extension
extension MainCardsTableViewCell{
    
    func setUpLayout(){
        
        self.backView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
            
        }
        
        self.cardTypeImg.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalToSuperview()
            
        }
        
        self.cardNumberLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.cardTypeImg.snp.centerY)
            $0.trailing.equalToSuperview().inset(5)
            $0.leading.equalTo(self.cardTypeImg.snp.trailing).offset(10)
        }
  
    }
}
