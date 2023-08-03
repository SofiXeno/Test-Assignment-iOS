//
//  CardNumberEncryptorDecryptorManager.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation
import RNCryptor

//MARK: - class for card number ecrypted saving
final class CardNumberEncryptorDecryptorManager {
    
    static let shared = CardNumberEncryptorDecryptorManager()
    var cryptoKey : String = "kadbvakj*^#!!)E*E@~!@)#~#~" //of course need to be changed and rethinked for more serious projects :)
    
    //MARK: - encrypt string
    func encryptString(string: String, encryptionKey: String) -> String {
        let messageData = string.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
     
        return cipherData.base64EncodedString()
    }
    
    //MARK: - decrypt string
    func decryptString(encryptedString: String, encryptionKey: String) -> String {
        
        let encryptedData = Data.init(base64Encoded: encryptedString)!
        guard let decryptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey) else { return String() }
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
     
        return decryptedString
    }
    
}
