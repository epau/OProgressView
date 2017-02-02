# OProgressView

[![carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg?style=flat)](https://github.com/epau/OProgressView)
[![DUB](https://img.shields.io/dub/l/vibe-d.svg)](https://github.com/epau/OProgressView)

You use the OProgressView class to show an ellipse to depict the progress of a task over time.

- [x] Supports any size ellipse, not just circles.
- [x] Provides a label that autopopulates with the current progress value (as a percent).
- [x] Set progress manually or by observing a Progress instance.
- [x] Available in Interface Builder.

## Installation

### Carthage
To install using [Carthage](), add the following to your project's Cartfile:
```
github "epau/OProgressView"
```

### Manually
Download and drag into your project all files within the **Source** folder:
```
OProgressView.swift
CGPoint+PointOnEllipse.swift
FloatingPoint+DegreesToRadians.swift
UIBezierPath+Percentage.swift
```

## Requirements

Xcode 8  
Swift 3.0  
iOS 8.0 +

## Usage
Initialize an instance of OProgressView just like any other UIView.
```swift
let oProgressView = OProgressView()

// Or pass in a frame
let oProgressView = OProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

```

Adjust the current progress, optionally animating the change.
```swift
oProgressView.setProgress(0.80, animated: true)
```

Or observe a Progress instance.
```swift
let progress = Progress(totalUnitCount: 100)

oProgressView.observedProgress = progress
```

OProgressView's API should feel very familiar as it is designed to match UIProgressView's API.  
Many of the same properties are exposed to control the style of the progress view.
```swift
// The color shown for the portion of the progress bar that is not filled.
var trackTintColor: UIColor?
// An image to use for the portion of the track that is not filled.
var trackImage: UIImage?
// The color shown for the portion of the progress bar that is filled.
var progressTintColor: UIColor?
// An image to use for the portion of the progress bar that is filled.
var progressImage: UIImage?
```

There are some additional properties as well.
```swift
// The width of the track around the ellipse.
var trackWidth: CGFloat
// The label to display the current progress as a percentage.
var progressLabel: UILabel
// The color shown in the inside of the circle.
var centerBackgroundColor: UIColor?
```

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Author
Made by [epau](https://github.com/epau) with ❤️

## Credits
Influenced by [iOS-CircleProgressView](https://github.com/CardinalNow/iOS-CircleProgressView)

## License

Licensed under the MIT license. See [LICENSE](https://github.com/epau/OProgressView/blob/master/LICENSE) for details
