# DRSwipeMenu (iOS)

## Changelog

##### v2.0.5

> - Add `previewLeftMenuAnimated:offset:` and `previewRightMenuAnimated:offset:` methods to `DRSwipeMenuView`

> [see diff](../../compare/v2.0.4...v2.0.5)

##### v2.0.4

> - Fix revelaing right menu without animation
> - Minor improvements

> [see diff](../../compare/v2.0.3...v2.0.4)

##### v2.0.3

> - Added `scrollDeceleationRate` property to `DRSwipeMenuView`

> [see diff](../../compare/v2.0.2...v2.0.3)

##### v2.0.2

> - Added `shouldDisableScrollingWhileDecelerating` property to `DRSwipeMenuView`. If set to `YES`, scrolling will be disabled during deceleration. This could improve UX when embedding swipe menu in other scroll views (eg when adding swipe menu to cells in table view). Default value is `NO`.
> - Example app updated using Xcode 8
> - Minimum deployment target bumped to iOS 8
> - Added documentation comments to all public headers

> [see diff](../../compare/v2.0.1...v2.0.2)

##### v2.0.1

> - Added `shouldCloseByTapingOnMainView` property to `DRSwipeMenuView`. If set to `YES`, tapping on center view closes menu. This will block user interactions with center view while menu is revealed. Default value is `NO`.

> [see diff](../../compare/v2.0.0...v2.0.1)

##### v2.0.0

> - Source code refactored and cleaned up
> - Supports left and right swipe menu
> - Example app updated

> [see diff](../../compare/v1.0.0...v2.0.0)

##### v1.0.0

> - Initial release
> - Right swipe menu
> - iOS 7 and iOS 8 compatible
