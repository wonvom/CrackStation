# **CrackStation**
### **This package can decrypt your encrypted code.**

## OverView
It can be decrypted with a crack password made from hash code such as SAH1 and SHA256.

## Mission Statement
First, this library is written in Swift. Therefore, it will be useful for those who want to learn Swift syntax.

Second, this library is simple decryption. Therefore, the purpose is to remind you to use strong passwords as simple passwords can easily be compromised.

Thirdly, it is not directly visible how this API works, which can confuse hackers.

## Installation
 If you want to use this API then follow the description.

 1. You need to add this dependency in the Package file. (Check my version of tag)


```Swift
{
	dependencies: [
        	// Dependencies declare other packages that this package depends on.
        	.package(url: "git@github.com:ethan9438/CrackStation.git", from: "2.0.7")
    	]
}
```

 2. Go to the File->Packages->Reset package caches

 3. You have to make object like this

```Swift
{
	testObject = CrackStation()
}
```
 
 4. Done.

## API
```Swift
{
	public protocol Decrypter {
    	init()
    
	    /// Either returns the cracked plain-text password
	    /// or, if unable to crack, then returns nil.
	    /// - Parameter shaHash: The SHA-1 or SHA-256 digest that corresponds to the encrypted password.
	    /// - Returns: The underlying plain-text password if `shaHash` was successfully cracked. Otherwise returns nil.
	    func decrypt(shaHash: String) -> String?
	}
}
```
## Example
```Swift
{
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
}
```

## Author
> NAME : Wonjong Kim (Ethan)
