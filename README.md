# Alamofire - Prephirences
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat
            )](http://mit-license.org) [![Platform](http://img.shields.io/badge/platform-ios_osx-lightgrey.svg?style=flat
             )](https://developer.apple.com/resources/) [![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift) [![Cocoapod](http://img.shields.io/cocoapods/v/Alamofire-Prephirences.svg?style=flat)](http://cocoadocs.org/docsets/Alamofire-Prephirences/)


[<img align="left" src="logo-128x128.png" hspace="20">](#logo) Remote preferences and configurations for your application.

By using remote preferences you can remotely control the behavior of your app, allowing you to active a feature, to make impromptu A/B tests, or to add a simple "message of the day".

It's built on top of [Alamofire](https://github.com/Alamofire/Alamofire) and [Prephirences](https://github.com/phimage/Prephirences), and provides methods to load from remote `plist` or `json` files.

# Usage #
### Load with URL(Convertible)
On your `NSUserDefault` or any `MutablePreferencesType`

```swift
 mutablePref.loadPropertyListFromURL("http://example.com/pref.plist")
```
...or if you need a callbacks for success/failure
```swift
mutablePref.loadPropertyListFromURL("http://example.Com/pref.plist",
		completionHandler: { response in
			switch response.result {
				case .Success:
				...
				case .Failure(let error):
				...
            }
		}
)
```

And for JSON just change `loadPropertyListFromURL` by `loadJSONFromURL`
```swift
 mutablePref.loadJSONFromURL("http://example.com/pref.json")
```

### Load with URLRequest
For more complex request, instead of use simple URL you can create your own `NSURLRequest`

```swift
let url = NSURL(string: "http://example.com/pref.plist")!
let mutableURLRequest = NSMutableURLRequest(URL: url)
mutableURLRequest.HTTPMethod = "GET"
... (add HTTPHeader, etc...)

mutablePref.loadPropertyListFromURLRequest(mutableURLRequest)
```



# Setup #

## Using [cocoapods](http://cocoapods.org/) ##

If not already done :
- Add `pod 'Alamofire'` to your `Podfile`.
- Add `pod 'Prephirences'` to your `Podfile`.

Then :
- Add `pod 'Alamofire-Prephirences'` to your `Podfile` and run `pod install`.

*Add `use_frameworks!` to the end of the `Podfile`.*

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