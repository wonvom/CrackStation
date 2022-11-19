import Foundation
import CryptoKit

public struct CrackStation: Decrypter {
    
    private var characterTable = [String: String]()
    
    // initialize
    public init() {
        characterTable = (try? self.loadDictionaryFromDisk(from: "data")) ?? [:]
        
    }
    
    // Decryption function
    public func decrypt(shaHash: String) -> String? {
        return CheckTable(from:shaHash)
    }
    
    // CheckTable Function
    private func CheckTable(from input: String) -> String? {
        let password = characterTable[input]
        
        if password != nil {
            return password
        }
        
        return nil
    }
    
    
    // load data json files Function
    private func loadDictionaryFromDisk(from tableName: String) throws -> [String : String] {
        guard let path = Bundle.module.url(forResource: tableName, withExtension: "json") else { return [:] }
        let data = try Data(contentsOf: path)
        let jsonResult = try JSONSerialization.jsonObject(with: data)
        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
            return lookupTable
        } else {
            print("error:")
            return [:]
        }
    }
}


