# DRSwipeMenu (iOS)

Customizable swipe-to-reveal menu for iOS apps. Compatible with iOS 7 and later, tested under iOS 7 and iOS 8.

![DRSwipeMenu iOS screenshot 1](Misc/DRSwipeMenu-iOS-screenshot-1.png "DRSwipeMenu iOS screenshot 1") ![DRSwipeMenu iOS screenshot 2](Misc/DRSwipeMenu-iOS-screenshot-2.gif "DRSwipeMenu iOS screenshot 2")

## Instalation

You can integrate `DRSwipeMenu` with your project using Cocoapods. To do so, you will need to add following line to your Podfile:

    pod 'DRSwipeMenu', '~> 2.0'

You can also download zip archive of given release from [releases page](https://github.com/darrarski/DRSwipeMenu-iOS/releases).

## Usage

Check out included example project. It shows how to use swipe menu on `UITableViewCell`, but menu could be embedded anywhere in the view hierarchy.

## Changelog

##### v2.0.3

> - Added `scrollDeceleationRate` property to `DRSwipeMenuView`

##### v2.0.2

> - Added `shouldDisableScrollingWhileDecelerating` property to `DRSwipeMenuView`. If set to `YES`, scrolling will be disabled during deceleration. This could improve UX when embedding swipe menu in other scroll views (eg when adding swipe menu to cells in table view). Default value is `NO`.
> - Example app updated using Xcode 8
> - Minimum deployment target bumped to iOS 8
> - Added documentation comments to all public headers

##### v2.0.1

> - Added `shouldCloseByTapingOnMainView` property to `DRSwipeMenuView`. If set to `YES`, tapping on center view closes menu. This will block user interactions with center view while menu is revealed. Default value is `NO`.

##### v2.0.0

> - Source code refactored and cleaned up
> - Supports left and right swipe menu
> - Example app updated

##### v1.0.0

> - Initial release
> - Right swipe menu
> - iOS 7 and iOS 8 compatible


## License

The MIT License (MIT) - check out included [LICENSE](LICENSE) file

Icons used in example app comes from [icons8.com](http://icons8.com/) site.
