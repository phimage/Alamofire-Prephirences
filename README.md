# Alamofire - Prephirences
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios_osx-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)
[![Cocoapod](http://img.shields.io/cocoapods/v/Alamofire-Prephirences.svg?style=flat)](http://cocoadocs.org/docsets/Alamofire-Prephirences/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


[<img align="left" src="logo.png" hspace="20">](#logo) Remote preferences and configurations for your application.

By using remote preferences you can remotely control the behavior of your app, allowing you to active a feature, to make impromptu A/B tests or to add a simple "message of the day".

It's built on top of [Alamofire](https://github.com/Alamofire/Alamofire) and [Prephirences](https://github.com/phimage/Prephirences), and provides methods to load from remote `plist` or `json` files.
You can also have custom format like `xml` or `yaml`

# Usage #
### Load from URL
On your `UserDefault` or any `MutablePreferencesType` for `plist`

```swift
 pref.loadPropertyList(from: "http://example.com/pref.plist")
```
...or if you need a callback for success/failure
```swift
pref.loadPropertyList(from: "http://example.Com/pref.plist",
		completionHandler: { response in
			switch response.result {
				case .success:
				...
				case .failure(let error):
				...
            }
		}
)
```

And for `JSON`format, just change `loadPropertyList` by `loadJSON`
```swift
 pref.loadJSON(from: "http://example.com/pref.json")
```

## Custom format
You can also use custom alamofire `DataResponseSerializer`, which must convert file to `Dictionary`
```swift
 pref.load(from: "http://example.com/pref.ext", format: .custom(MyReponseSerializer))
```
Some repo with other format
- XML : [AlamofireXMLRPC](https://github.com/kodlian/AlamofireXMLRPC)
- Yaml : [Alamofire-YamlSwift] (https://github.com/phimage/Alamofire-YamlSwift)

### Load from URLRequest
For more complex request, instead of using simple URL, you can implement alamofire `URLRequestConvertible` or provide your own `URLRequest`

```swift
let url = URL(string: "http://example.com/pref.plist")!
var urlRequest = URLRequest(url: url)
urlRequest.httpMethod = "GET"
... (add HTTPHeader, etc...)

mutablePref.loadPropertyList(from: urlRequest)
```

# Setup #

## Using [cocoapods](http://cocoapods.org/) ##

If not already done you can optionally :
- Add `pod 'Alamofire'` to your `Podfile`.
- Add `pod 'Prephirences'` to your `Podfile`.

Then :
- Add `pod 'Alamofire-Prephirences'` to your `Podfile` and run `pod install`.

*Don't forget to add `use_frameworks!` to the end of the `Podfile`.*

## Using Carthage ##
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Objective-C and Swift.

1. Add the project to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

    ```
    github "phimage/Alamofire-Prephirences"
    ```

2. Run `carthage update` and follow [the additional steps](https://github.com/Carthage/Carthage#getting-started)
   in order to add Alamofire-Prephirences to your project.

# Licence #
```
The MIT License (MIT)

Copyright (c) 2015 Eric Marchand (phimage)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
