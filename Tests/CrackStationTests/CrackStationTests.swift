//
//  MPV_SHA-256_Tests.swift
//
//
//  Created by Will on 11/24/22.
//

import XCTest
import CrackStation
import CryptoKit

// The global constant to switch from POC to MVP character set
let alphabet = PRD.mvp.alphabet

private enum PRD {
    case poc, mvp

    private static let baseAlphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    var alphabet: String {
        switch self {
        case .poc: return Self.baseAlphabet
        case .mvp: return "\(Self.baseAlphabet)?!"
        }
    }
}


class LookupTable {
    // MARK: - API

    static let shared = LookupTable()

    var totalHashes: Int {
        passwords.count
    }

    func decrypt(sha: String) -> String? {
        return passwords[sha]
    }

    private(set) var sha1s: [String: String] = [:]
    private(set) var sha2s: [String: String] = [:]

    private(set) var justPasswords_1letter: [String] = []
    private(set) var justPasswords_2letter: [String] = []
    private(set) var justPasswords_3letter: [String] = []

    // MARK: - Private implementation

    private var passwords: [String: String] = [:]

    private init() {
        addPasswords_1letter()
        addPasswords_2letter()
        addPasswords_3letter()
    }

    private func encryptAndAdd_1letter(_ password: String) {
        justPasswords_1letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func encryptAndAdd_2letter(_ password: String) {
        justPasswords_2letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func encryptAndAdd_3letter(_ password: String) {
        justPasswords_3letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func addPasswords_1letter() {
        for letter in alphabet {
            let password = String(letter)
            encryptAndAdd_1letter(password)
        }
    }

    private func addPasswords_2letter() {
        for a in alphabet {
            for b in alphabet {
                let password = String("\(a)\(b)")
                encryptAndAdd_2letter(password)
            }
        }
    }

    private func addPasswords_3letter() {
        for a in alphabet {
            for b in alphabet {
                for c in alphabet {
                    let password = String("\(a)\(b)\(c)")
                    encryptAndAdd_3letter(password)
                }
            }
        }
    }
}

private func sha1(_ password: String) -> String {
    let dataToHash = Data(password.utf8)
    let prefix = "SHA1 digest: "
    let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
    let shaHash = String(shaHashDescription.dropFirst(prefix.count))
    return shaHash
}

private func sha256(_ password: String) -> String {
    let dataToHash = Data(password.utf8)
    let prefix = "SHA256 digest: "
    let shaHashDescription = String(SHA256.hash(data: dataToHash).description)
    let shaHash = String(shaHashDescription.dropFirst(prefix.count))
    return shaHash
}

final class Test_the_tests: XCTestCase {
    private let crackStation = CrackStation()
    
    func testTheTest() {
        let totalHashes = LookupTable.shared.totalHashes
        XCTAssertEqual(totalHashes, LookupTable.shared.sha1s.count + LookupTable.shared.sha2s.count)

        let totalPasswords =
        LookupTable.shared.justPasswords_1letter.count +
        LookupTable.shared.justPasswords_2letter.count +
        LookupTable.shared.justPasswords_3letter.count
        XCTAssertEqual(totalHashes / 2, totalPasswords)
    }
    
}

final class MPV_SHA_256_Tests: XCTestCase {
    private let crackStation = CrackStation()    

    // MARK: - Happy path for SHA-256

    func test_sha256_1letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_1letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_1letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)

            // Then
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha256_2letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha256_3letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

}
final class MPV_SHA_1_Tests: XCTestCase {
    private let crackStation = CrackStation()
    
    // MARK: - Happy path for SHA-1

    func test_sha1_1letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_1letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_1letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            // Then
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha1_2letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha1_3letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
}
