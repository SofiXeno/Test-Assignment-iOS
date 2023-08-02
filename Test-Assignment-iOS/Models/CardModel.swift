//
//  CardModel.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import UIKit
import CoreData

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



final class CardModel {
    
    let timestamp: Int
    let cardType : CardType?
    let cardNumber : String
    
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
        
        print(card.value(forKey: CardProperties.timestamp.rawValue) as! Int)
        print(CardType(rawValue: card.value(forKey: CardProperties.cardType.rawValue) as! String))
        print(card.value(forKey: CardProperties.cardNumb.rawValue) as! String)
        self.timestamp = card.value(forKey: CardProperties.timestamp.rawValue) as! Int
        self.cardType = CardType(rawValue: card.value(forKey: CardProperties.cardType.rawValue) as! String)
        self.cardNumber = CardNumberEncryptorDecryptorManager.shared.decryptString(encryptedString: card.value(forKey: CardProperties.cardNumb.rawValue) as! String, encryptionKey: CardNumberEncryptorDecryptorManager.shared.cryptoKey)
    }
    
    
    func maskCardNumberForTable() -> String? {

        let trimmedCardNumber = self.cardNumber.filter { $0.isNumber }
           let lastFourDigits = String(trimmedCardNumber.suffix(4))
           let maskedDigits = String(repeating: "*", count: trimmedCardNumber.count - 4)
           
           var maskedCardNumber = ""
           var currentIndex = 0
           
           for char in cardNumber {
               if char.isNumber {
                   if currentIndex < maskedDigits.count {
                       maskedCardNumber.append(maskedDigits[maskedDigits.index(maskedDigits.startIndex, offsetBy: currentIndex)])
                       currentIndex += 1
                   } else {
                       maskedCardNumber.append(char)
                   }
               } else {
                   maskedCardNumber.append(char)
               }
           }
           
           return maskedCardNumber
        
//        let regexPattern = "(?<=.{0}).(?=.*.{4}$)"
//        return try? self.cardNumber.split(separator: " ").description.masked(matching: regexPattern)
//
    }
}



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
        
        print("AAAAA", cardNumber)
        return cardNumber
    }
}
