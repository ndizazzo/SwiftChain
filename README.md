## What is SwiftChain?

SwiftChain is a simple implementation of a blockchain, written purely in Swift.

The goal if SwiftChain is to provide a strong foundation layer for any and all interesting applications of blockchain that you might want to build. 

# Installation

## Manual Installation

In order to correctly compile SwiftChain (in Xcode):

1. You must be using a workspace.
1. Drag the `SwiftChain.xcodeproj` to your workspace  
1. Drag the `CryptoSwift.xcodeproj` to your workspace  
2. Go to your target's settings, hit the "+" under the "Embedded Binaries" section, and select `SwiftChain.framework`  
3. `@import SwiftChain`

# Usage

## Implementing SwiftChain in your Project
To work with `SwiftChain`, first `import SwiftChain` into the relevant files where you'd like to use it.  

Then, create a new blockchain by calling the `Blockchain()` constructor. Optionally, you may provide data that should be included in the genesis block of your blockchain. See the documentation for details.

Once you have a `Blockchain` object, you can use: 
```swift
let blockchain = Blockchain()
let myData = "some data object".data(using: .utf8)!
blockchain.addBlock(with: myData)
``` 

This will:
1. Begin hashing the provided data using the algorithm the blockchain is supporting. This call is blocking, and can potentially take a long time.
1. Append that data into a new block.
1. Extend your blockchain object by one block.

# Feature Roadmap

Feel free to open an issue to request a feature you'd like to see!

# Troubleshooting

### Can't compile?

* Please note the difference between installing a compiled framework from CocoaPods or Carthage, and copying the source code
* Search issues
* Ask in the issues section

### Other problems / Feature requests

* Search issues
* Ask in the issues section

# Other

## 3rd party software

SwiftChain depends on [CryptoSwift](https://cryptoswift.io). 

CryptoSwift is a collection of cryptographic algoriths and tools implemented in Swift. CryptoSwift is essential to keep SwiftChain accessible to as many platforms as possible, by not depending on pre-compiled system crypto tools.

## Contributing

If you have ideas or like what you see here and want to support the project, you could:
* Let people know this library exists (🚀 spread the word 🚀)
* Contribute code, issues and pull requests

## Questions & Issues

If you have questions or are having problems, you should:

 - Make sure you are using the latest version of the library. Check the [**release-section**](https://github.com/ndizazzo/SwiftChain/releases).
 - Search or ask questions on [**stackoverflow**](http://stackoverflow.com/questions/tagged/SwiftChain) with the `SwiftChain` tag
 - Search [**known issues**](https://github.com/ndizazzo/SwiftChain/issues) for your problem (open and closed)
 - Create new issues (please **search known issues beforehand** and avoid creating duplicate issues)

## Documentation
I have written Xcode quick-help documentation for the library. Since this library is generally the key building blocks for a project, having it close to the source is the best approach. Please refer to [**Apple's Documentation**](https://developer.apple.com/library/content/documentation/Xcode/Reference/xcode_markup_formatting_ref/SymbolDocumentation.html) for writing quick help documentation.

## License

SwiftChain is available under the MIT license. See the LICENSE file for more information.