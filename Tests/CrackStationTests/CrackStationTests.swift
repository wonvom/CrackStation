import XCTest
import CrackStation
import CryptoKit

final class CrackStationTests: XCTestCase {
    
    func testAllOneLetter() throws {
        
        let crackStation = CrackStation()
        
        for firstLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            
            // Given
            let password = String("\(firstLetter)")
            let shaHash = encrypt(password)
            
            // When
            let crackedPassword = crackStation.decrypt(shaHash: shaHash)
            
            // Then
            XCTAssertEqual(crackedPassword, password)
        }
        
    }
    
    // Test 2 parameters in Sha1
    func testAllTwoLetter() throws {
        
        let crackStation = CrackStation()
        
        for firstLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            for secondLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
                
                // Given
                let password = String("\(firstLetter)\(secondLetter)")
                let shaHash = encrypt(password)
                
                // When
                let crackedPassword = crackStation.decrypt(shaHash: shaHash)
                
                // Then
                XCTAssertEqual(crackedPassword, password)
            }
        }
    }
    
    func testAllThreeLetter() throws {
        
        let crackStation = CrackStation()
        
        for firstLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            for secondLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
                for thirdLetter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
                    
                    // Given
                    let password = String("\(firstLetter)\(secondLetter)\(thirdLetter)")
                    let shaHash = encrypt(password)
                    
                    // When
                    let crackedPassword = crackStation.decrypt(shaHash: shaHash)
                    
                    // Then
                    XCTAssertEqual(crackedPassword, password)
                }
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
