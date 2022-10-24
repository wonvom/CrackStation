import XCTest
@testable import CrackStation
import CryptoKit

final class CrackStationTests: XCTestCase {
    
    func testLoadingLookupTableFromDisk() throws {
        // When
        let lookupTable = try CrackStation.loadDictionaryFromDisk()
        let answer = lookupTable["84a516841ba77a5b4648de2cd0dfcb30ea46dbb4"]
        
        // Then
        XCTAssertEqual(answer, "c")
    }
    
    func testExample() throws {
        // Without the helper function:

        let inputString = "7"
        let inputData = Data(inputString.utf8)

        let output = Insecure.SHA1.hash(data: inputData)
        print(output)

        // With the helper function:

        func encryptUsingSha1(from input: String) -> String {
            let inputData = Data(input.utf8)
            let output = Insecure.SHA1.hash(data: inputData)
            return output.description
        }

        let sha1 = encryptUsingSha1(from: "7")
        print(sha1)
    }
}
