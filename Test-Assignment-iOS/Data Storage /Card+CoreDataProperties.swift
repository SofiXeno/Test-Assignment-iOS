//
//  Card+CoreDataProperties.swift
//  
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//
//

import Foundation
import CoreData

enum CardProperties: String {
    case cardNumb, timestamp, cardType
}


extension Card {
    
    static let entityName = "Card"

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cardNumb: String?
    @NSManaged public var timestamp: Int64
    @NSManaged public var cardType: String?
    

}

extension Card : Identifiable {
    
    func changeFromCardModel(cardModel: CardModel){

        let encryptedCardNumb = CardNumberEncryptorDecryptorManager.shared.encryptString(string: cardModel.cardNumber, encryptionKey: CardNumberEncryptorDecryptorManager.shared.cryptoKey)
        
        guard let cardType = cardModel.cardType else { return }
        
        self.setValue(encryptedCardNumb as NSString, forKey: CardProperties.cardNumb.rawValue)
        self.setValue(cardModel.timestamp as NSNumber, forKey: CardProperties.timestamp.rawValue)
        self.setValue(cardType.rawValue as NSString, forKey: CardProperties.cardType.rawValue)
        
    }
    
}
