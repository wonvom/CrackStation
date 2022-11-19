import Foundation
import CryptoKit

public struct CrackStation: Decrypter {
    
//    private var singleCharacterTable = [String: String]()
//    private var doubleCharacterTable = [String: String]()
    private var threeCharacterTable = [String: String]()
    
    // initialize
    public init() {
//        singleCharacterTable = (try? self.loadDictionaryFromDisk(from: "data1")) ?? [:]
//        doubleCharacterTable = (try? self.loadDictionaryFromDisk(from: "data2")) ?? [:]
        threeCharacterTable = (try? self.loadDictionaryFromDisk(from: "data3")) ?? [:]
        
    }
    
    // Decryption function
    public func decrypt(shaHash: String) -> String? {
        return CheckTable(from:shaHash) // If the hashcode get in to the decrypt function, then check the table.
    }
    
    // Crack Function
    //    public func crack(_ _string: String) -> String? {
    //        return CheckTable(from:_string) // If the string get in to the crack function, then check the table.
    //    }
    
    // CheckTable Function
    private func CheckTable(from input: String) -> String? {
        //        let password1 = singleCharacterTable[input]
        //
        //        if password1 != nil {
        //            return password1
        //        } else {
        //            let password2 = doubleCharacterTable[input]
        //            return password2
        //        }
        let password = threeCharacterTable[input]
        
        if password != nil {
            return password
        }
        
        return nil
    }
    
    // Encrypt Function with SHA1
    //    private func encryptUsingSha1(from input: String) -> String {
    //        let inputData = Data(input.utf8)
    //        let output = Insecure.SHA1.hash(data: inputData)
    //        return output.description
    //    }
    
    
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


