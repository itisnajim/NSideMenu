# NSideMenu

## Description
A simple customizable side menu written in SwiftUI.

[![Platform](https://img.shields.io/badge/Platform-iOS-brightgreen)](https://github.com/itisnajim/NSideMenu)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager)
[![CocoaPods](https://img.shields.io/cocoapods/v/NSideMenu.svg)](https://cocoapods.org/pods/NSideMenu)
[![License](https://img.shields.io/github/license/itisnajim/NSideMenu)](https://raw.githubusercontent.com/itisnajim/NSideMenu/master/LICENSE)

## Give a Star! ⭐
Feel free to request an issue on github if you find bugs or request a new feature. 
If you find this useful, please give it a star to show your support for this project.

## Example
You can check [the example app repo](https://github.com/itisnajim/NSideMenuApp) too.

![Example](https://github.com/itisnajim/NSideMenuApp/blob/main/example.gif?raw=true)


## Installation

### Via Swift Package Manager:
Copy this url: 
```https://github.com/itisnajim/NSideMenu.git```
then in Xcode project, select File > Add Packages... and past it in the input with the placeholder 'Search or Enter package URL'

### Via CocoaPods
```ruby
pod 'NSideMenu'
```

Then import framework where you need to use the library:
```swift
import NSideMenu
```

## Usage
In your content view body add NSideMenuView like the code below:
```swift
    @StateObject var options = NSideMenuOptions()
    var body: some View {
        NSideMenuView(options: options){
            Menu{
                YourMenuView()
            }
            Main{
                YourMainView()
            }
        }
    }
```

## Customization
You can Customize NSideMenuView via NSideMenuOptions viewModel.
```swift
    options = NSideMenuOptions(
    style: .normal, side: .leading, width: 220,
    showSkeletonStack: false, skeletonStackColor: .white,
    cornerRaduisIfNeeded: 16, rotationDegreeIfNeeded: 8,
    onWillClose: {
        print("menu:onWillClose!")
    }, onWillOpen: {
        print("menu:onWillOpen!")
    }, onDidClose: {
        print("menu:onDidClose!")
    }, onDidOpen: {
        print("menu:onDidOpen!")
    })
    // or
    options.style = .slideAbove
    ...
```

### NSideMenuOptions Properties
| Option | Type | Default value | Description |
| :- | :- | :- | :- |
| `style` |`NSideMenuStyle` | `.normal` | Presentation Style |
| `side` |`NSideMenuSide` | `.leading` | Menu presentation side |
| `width` |`CGFloat` | `186` | Menu content container width |
| `showSkeletonStack` |`Bool` | `false` | Main view content Skeleton stack visiblity |
| `skeletonStackColor` |`Color` | `Color(UIColor.systemBackground)` | Main view content Skeleton stack color |
| `cornerRaduisIfNeeded` |`CGFloat` | `16` | When style is scale and Menu is visible this property will be applied on the Main view container corners. |
| `rotationDegreeIfNeeded` |`Double` | `6` | When style is rotate and Menu is visible this property will be applied on the Main view container rotation degree. |
| `show` |`Bool` | `false` | Side menu view visiblity |


### NSideMenuOptions Methods and Events
+ onWillClose: fired when 'show' property asigned to false or when calling toggleMenu Method.
+ onWillOpen:  fired when 'show' property asigned to true or when calling toggleMenu Method.
+ onDidClose:  fired when the side menu close animation did finish.
+ onDidOpen:   fired when the side menu open animation did finish.
+ toggleMenu(animation: Animation? = .default): this method to toggle the side menu visiblity from open to close or from close to open.
+ showMenu(animation: Animation? = .default): this method to open the side menu
+ hideMenu(animation: Animation? = .default): this method to close the side menu

## Roadmap
+ Make the code cleaner.
+ Edge Drag Gesture to open or close the side menu. 

## Author

itisnajim, itisnajim@gmail.com

## License

NSideMenu is available under the MIT license. See the LICENSE file for more info.

