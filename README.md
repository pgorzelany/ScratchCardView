# ScratchCardView

[![Version](https://img.shields.io/cocoapods/v/ScratchCardView.svg?style=flat)](http://cocoapods.org/pods/ScratchCardView)
[![License](https://img.shields.io/cocoapods/l/ScratchCardView.svg?style=flat)](http://cocoapods.org/pods/ScratchCardView)
[![Platform](https://img.shields.io/cocoapods/p/ScratchCardView.svg?style=flat)](http://cocoapods.org/pods/ScratchCardView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ScratchCardView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ScratchCardView"
```

## Documentation

Extensive documentation can be found [Here](https://pgorzelany.github.io/ScratchCardView/).

Special thanks to the [Jazzy](https://github.com/realm/jazzy) project for automatic documentation generation.

## Usage

See the example project for usage.

![](https://thumbs.gfycat.com/FlakyDangerousHorsemouse-size_restricted.gif)

You can setup custom views for both the scratch card cover and the cratch card content.
The setup is done through a delegate.

```
class YourViewController: UIViewController {
    ...
    override func viewDidLoad() {
        super.viewDidLoad()

        configureScratchCardView()
    }

    private func configureScratchCardView() {
        scratchCardView.delegate = self
        scratchCardView.scratchWidth = 150
    }
}

extension YourViewController: ScratchCardViewDelegate {

    func coverView(for scratchCardView: ScratchCardView) -> UIView {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.gray
        return coverView
    }

    func contentView(for scratchCardView: ScratchCardView) -> UIView {
        let imageView = UIImageView(image: yourCustomImage)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

```

That is all you need to know, its that simple :)

If you want to reload the ScratchCardView call:

```
scratchCardView.reloadView()
```

This will trigger a call to your delegate for a new cover and content view.

## Author

pgorzelany, piotr.gorzelany@gmail.com

## License

ScratchCardView is available under the MIT license. See the LICENSE file for more info.
