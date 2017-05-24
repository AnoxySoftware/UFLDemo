# UFL Demo App

[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)](http://developer.apple.com/iOS)&nbsp;

UFL Demo App is a coding sample `Swift 2.3` iOS Application

> The application doesn't use any librariers as it was simple to create it.
> Normally we should have used Cocoapods to add library dependencies

  - Uses `AutoLayout` for the entire UI
  - Uses extensions and subclasses for extra functionality on UI Elements
  - Has `Unit Tests`

### Tech

Explanation of the application design
```
 - Application design pattern is the MVVM pattern 
 - App creates mock data from Plist files for the leagues and teams that assets have been added to this sample
 - Has a fake pull to refresh on the UITableView, which adds a fake 2 second delay, then creates new random mock data
 - Has a filter for filtering out leagues, which can be toggled by the filter button on the UINavigation Bar
 - Filter bar is animated and uses a UICollectionView for simplicity
 - When applying the filter a simple crossfade animation is used to animate the changes. This could be changed to a more fancy animation by tracking down all the insertions and deletions, then animating those with a custom animation
 - Uses an extension for UIColor to provide global app colors
 - The UIShadowView was created as a subclass and not an extension as extending the UIView globally would be probably too dangerous
 - Uses KVO to notify the View about Model Changes. This ideally would be done using FRP, but I'm yet learning Reactive Programming, so I opted in to use KVO
```

&copy; 2017 Lefteris Haritou