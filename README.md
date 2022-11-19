# **CrackStation**
## **This package can decrypt your encrypted code.**


## Mission Statement
 If you want to decrypt an encrypted hashcode into a plaintext password, this API will help.
 You don't need to search the code manually.

## Installation
 If you want to use this API then follow the description.

 1. You need to add this dependency in the Package file. (Check my version of tag)

'''

    dependencies: [
            // Dependencies declare other packages that this package depends on.
            .package(url: "git@github.com:ethan9438/CrackStation.git", from: "2.0.0")
    ]
'''            

 2. Go to the File->Packages->Reset package caches

 3. You have to make object like this

'''

	testObject = CrackStation()    
'''

 4. Done.

## API
'''

    public protocol Decrypter {
        init()
        
        /// Either returns the cracked plain-text password
        /// or, if unable to crack, then returns nil.
        /// - Parameter shaHash: The SHA-1 or SHA-256 digest that corresponds to the encrypted password.
        /// - Returns: The underlying plain-text password if `shaHash` was successfully cracked. Otherwise returns nil.
        func decrypt(shaHash: String) -> String?
    }
    
'''

## Example
'''

    import CrackStation

    public struct CrackStationWrapper: Decrypter {
        private let testObject: Decrypter

        public init() {
            testObject = CrackStation()
        }

        public func decrypt(shaHash: String) -> String? {
            let crackedPassword = testObject.decrypt(shaHash: shaHash)
            return crackedPassword
        }
    }
    
'''

## Author
> NAME : Wonjong Kim (Ethan)
