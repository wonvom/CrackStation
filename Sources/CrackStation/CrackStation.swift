import Foundation
import CryptoKit


public struct CrackStation: Decrypter{
    
    
    
    public init() {
        
    }
    
    let Char = ["a", "b", "c", "d", "e"]
    
    private func encryptDictionary(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA 1 digest: "
        let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
        let shaHash = String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    
    }
    
    public func decrypt(shaHash: String) -> String?{
        var dict: [String: String] = [:]
        for i in Char {
            dict[encryptDictionary(i)] = i
            
            for j in Char {
                let new_str = i+j
                dict[encryptDictionary(new_str)] = new_str
                
            }
        }
        print(dict)
        let n = dict[shaHash]
        return n
    }
    
//    public func decrypt(shaHash: String) -> String? {
//        // ??
//        let lookupTable = (try? CrackStation.loadDictionaryFromDisk()) ?? [:]
//        let answer = lookupTable["84a516841ba77a5b4648de2cd0dfcb30ea46dbb4"]
//        return answer
//    }
//
//    static func loadDictionaryFromDisk() throws -> [String : String] {
//
//        guard let path = Bundle.module.url(forResource: "data", withExtension: "json") else { return [:] }
//
//        let data = try Data(contentsOf: path)
//        let jsonResult = try JSONSerialization.jsonObject(with: data)
//
//        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
//            return lookupTable
//        } else {
//            return [:]
//        }
//    }
    
//    struct CrackStation: Decrypter {
//        init() {
//            // TODO: Implement
//        }
//
//        func decrypt(shaHash: String) -> String? {
//            // TODO: Implement
//
//        }
//    }
}





//struct MockCrackStation: Decrypter {
//    init() {}
//
//    func decrypt(shaHash: String) -> String? {
//        return nil
//    }
//}
//
//struct CrackStation: Decrypter {
//    init() {
//        // TODO: Implement
//    }
//
//    func decrypt(shaHash: String) -> String? {
//        // TODO: Implement
//    }
//}
