import XCTest
import CrackStation
import CryptoKit

final class CrackStationTests: XCTestCase {
    
    // SHA256 Test
    func testTheSHA256() {
        
        // Given
        let myTestStation = CrackStation()
        let pwdSha256 =  myTestStation.crack("aff024fe4ab0fece4091de044c58c9ae4233383a")
        
        // When
        let password  = "w"
        
        // Then
        XCTAssertEqual(pwdSha256, password)
        XCTAssertNotNil(pwdSha256)
        XCTAssert(pwdSha256 != "")
    }
    
    // Nil Test
    func testNil() {
        
        // Given
        let myTestStation = CrackStation()
        let testNilValue =  myTestStation.decrypt(shaHash: "aff024fe4ab0fece4091de044c58c9ae4233383b")
        
        // When
        
        // Then
        XCTAssert(testNilValue == nil)
    }
    
    // Decrypt Test
    func testDecrpt() {
        
        // Given
        let myTestStation = CrackStation()
        let testDecrptvalue =  myTestStation.decrypt(shaHash: "aff024fe4ab0fece4091de044c58c9ae4233383a")
        
        // When
        let password  = "w"
        
        // Then
        XCTAssertEqual(testDecrptvalue, password)
        XCTAssert(testDecrptvalue != nil)
    }
    
    // Test 2 parameters in Sha1
    func testAllTwoLetterSha1Permutations() throws {
        
        let myTestStation = CrackStation()
        
        for a in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            for b in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
                // Given
                let password = String("\(a)\(b)")
                let shaHash = encrypt(password)

                // When
                let crackedPassword = myTestStation.decrypt(shaHash: shaHash)

                // Then
                XCTAssertEqual(crackedPassword, password)
            }
        }
    }
    
    // MARK: - Helpers
    private func encrypt(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA 1 digest: "
        let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
        let shaHash = String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    }
}
