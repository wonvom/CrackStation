import Foundation
import CryptoKit

public struct CrackStation: Decrypter {
    
    // Anyone can read lookupTables publicly.
    // However, I can only set in via changing value, cannot be set from the outside.
    public private(set) var lookupTable1 = [String: String]()
    public private(set) var lookupTable2 = [String: String]()

    // initialize
    public init() {
        if(lookupTable1==[:]) { // if lookupTable1 has dictionary type
            do {
                lookupTable1 = try loadDictionaryFromDisk(from: "data1") // load data from data1 file
            }
            catch {
            }
        }
        if(lookupTable2==[:]) { // if lookupTable1 has dictionary type
            do {
                lookupTable2 = try loadDictionaryFromDisk(from: "data2") // load data from data2 file
            }
            catch {
            }
        }
    }

    // Decryption function
    public func decrypt(shaHash: String) -> String? {
        return CheckTable(from:shaHash) // If the hashcode get in to the decrypt function, then check the table.
    }
    
    // Crack Function
    public func crack(_ _string: String) -> String? {
        return CheckTable(from:_string) // If the string get in to the crack function, then check the table.
    }
    
    // CheckTable Function
    func CheckTable(from input: String) -> String? {
        if(lookupTable1[input]?.count==nil) {
            if(lookupTable2[input]?.count==nil) {
                return nil
            }
            else {
                return lookupTable2[input]!
            }
        }
        return lookupTable1[input]!
    }
    
    // Encrypt Function with SHA1
    func encryptUsingSha1(from input: String) -> String {
        let inputData = Data(input.utf8)
        let output = Insecure.SHA1.hash(data: inputData)
        return output.description
    }
    
    // Encrypt FUnction with SHA256
    func encryptUsingSha256(from input: String) -> String {
        let inputData = Data(input.utf8)
        let output = SHA256.hash(data: inputData)
        return output.description.replacingOccurrences(of: "SHA256 digest: ", with: "")
    }
    
    // load data json files Function
    func loadDictionaryFromDisk(from tableName: String) throws -> [String : String] {
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


