import Foundation

public class CrackStation: Decrypter{

    private let characterTable: [String : String]

    public required init(){
        do{
            characterTable = try CrackStation.loadDictionaryFromDisk()
        }
        catch{
            characterTable = ["":""]
        }
    }

    private static func loadDictionaryFromDisk() throws -> [String : String] {
        guard let path = Bundle.module.url(forResource: "data", withExtension: "json") else { return [:] }
        let data = try Data(contentsOf: path)
        let jsonResult = try JSONSerialization.jsonObject(with: data)
        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
            return lookupTable
        } else {
            return [:]
        }
    }

    public func decrypt(shaHash: String) -> String?{
        let n = characterTable[shaHash]
        return n
    }

}
