//
//  CardNumberEncryptorDecryptorManager.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import RNCryptor


final class CardNumberEncryptorDecryptorManager {
    
    static let shared = CardNumberEncryptorDecryptorManager()
    var cryptoKey : String = "kadbvakj*^#!!)E*E@~!@)#~#~"
    
    
    func encryptString(string: String, encryptionKey: String) -> String {
         let messageData = string.data(using: .utf8)!
         let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        
        print("encrypt",cipherData.base64EncodedString())
        
         return cipherData.base64EncodedString()
     }

     func decryptString(encryptedString: String, encryptionKey: String) -> String {

         let encryptedData = Data.init(base64Encoded: encryptedString)!
         guard let decryptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey) else { return String() }
         let decryptedString = String(data: decryptedData, encoding: .utf8)!
         
         print("decrypt",decryptedString)

         return decryptedString
     }
    


    
}
