//
//  CardModel.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import UIKit
import CoreData

//MARK: - CardType enum
enum CardType: String, CaseIterable  {
    
    case visa = "visa"
    case masterCard = "mastercard"
    
    var hexColor: Int {
        switch self {
        case .visa: return 0xfaaa13
        case .masterCard: return 0x222222
        }
    }
    
    var image : UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    static func randomCardType() -> Self? {CardType.allCases.randomElement()}

}


//MARK: - CardModel
final class CardModel {
    
    //MARK: - Properties
    let timestamp: Int
    let cardType : CardType?
    let cardNumber : String
    
    //MARK: - different inits
    init() {
        self.timestamp =  Int(Date().timeIntervalSince1970)
        self.cardType = CardType.randomCardType()
        self.cardNumber = CardModel.generateRandomCardNumber()
    }

    init(timestamp: Int, cardType: CardType, cardNumber: String) {
        self.timestamp = timestamp
        self.cardType = cardType
        self.cardNumber = cardNumber
    }
    
    init(card: NSManagedObject) {
        self.timestamp = card.value(forKey: CardProperties.timestamp.rawValue) as! Int
        self.cardType = CardType(rawValue: card.value(forKey: CardProperties.cardType.rawValue) as! String)
        self.cardNumber = CardNumberEncryptorDecryptorManager.shared.decryptString(encryptedString: card.value(forKey: CardProperties.cardNumb.rawValue) as! String, encryptionKey: CardNumberEncryptorDecryptorManager.shared.cryptoKey)
    }
    
    
    //MARK: - masking first 12 digits with asterisk(*)
    func maskCardNumberForTable() -> String? {
       
        let lastFour = String(" \(self.cardNumber.suffix(4))")
        let splittedCardNumber = self.cardNumber.replacingOccurrences(of: " ", with: "").prefix(12)
        var res = ""

        splittedCardNumber.forEach({ _ in
            res.append("*")
        })
        
        res.insert(separator: " ", every: 4)
        res += lastFour

        return res


    }
}


//MARK: - randomly generated card number
extension CardModel {
    static func generateRandomCardNumber() -> String {
        var cardNumber = ""
        let digitsPerGroup = [4, 4, 4, 4] // Number of digits in each group
        
        for (index, digits) in digitsPerGroup.enumerated() {
            for _ in 0..<digits {
                let randomDigit = Int.random(in: 0...9)
                cardNumber.append(String(randomDigit))
            }
            if index < digitsPerGroup.count - 1 {
                cardNumber.append(" ") // Add space between groups
            }
        }
        
        return cardNumber
    }
}





