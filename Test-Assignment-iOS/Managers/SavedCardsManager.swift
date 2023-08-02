//
//  SavedCardsManager.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import CoreData

final class SavedCardsManager : CoreDataManager<Card>{
    
    // MARK: - Singleton
    static let shared = SavedCardsManager()
    
//    func saveAllEvents(allEvents: [EventModel]){
//        allEvents.forEach({self.saveEvent(event: $0)})
//    }
    
    // MARK: - save new Card
    func saveCard(cardModel: CardModel){

      //  let fetchRequest: NSFetchRequest<Card> = Card.fetchRequest()
 
        // Create a new match object and set its properties
        let entity = NSEntityDescription.entity(forEntityName: Card.entityName, in: context)!
        let card = Card(entity: entity, insertInto: context)
          
        card.changeFromCardModel(cardModel: cardModel)
     
    
        self.saveContext()
        
    }
    
    // MARK: - read Card
    func readCards() -> [Card] {self.fetch(Card.self)}
    
    // MARK: - convertCardsToModels
    func convertCardsToModels(cardsArray: [NSManagedObject]) -> [CardModel] {
  
        
        var models: [CardModel] = []

        cardsArray.forEach({
        
            models.append(CardModel(card: $0)) })
    
        return models
    }
    
}
