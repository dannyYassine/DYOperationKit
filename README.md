# DYOperationKit

[![CI Status](http://img.shields.io/travis/dannyyassine/DYOperationKit.svg?style=flat)](https://travis-ci.org/dannyyassine/DYOperationKit)
[![Version](https://img.shields.io/cocoapods/v/DYOperationKit.svg?style=flat)](http://cocoapods.org/pods/DYOperationKit)
[![License](https://img.shields.io/cocoapods/l/DYOperationKit.svg?style=flat)](http://cocoapods.org/pods/DYOperationKit)
[![Platform](https://img.shields.io/cocoapods/p/DYOperationKit.svg?style=flat)](http://cocoapods.org/pods/DYOperationKit)

## About
Collection of Operation and possibly OperationQueue subclasses

### Core

* DYOperation base class
* DYGroupOperation

### Components

* DownloadURLRessourceOperation
* ImageCacheRessourceOperation
* SaveImageCacheRessource

### Operations

* DownloadImageRessourceOperation : *Composed of the following Operations*
    * *DownloadURLRessourceOperation*
    * *ImageCacheRessourceOperation*
    * *SaveImageCacheRessource*

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DYOperationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DYOperationKit'
```

## Author

dannyyassine, dannyyassine@gmail.com

## License

DYOperationKit is available under the MIT license. See the LICENSE file for more info.
