# ViewModelable

[![Issues on Waffle](https://img.shields.io/badge/issues on-Waffle-blue.svg)](http://waffle.io/legoless/ViewModelable)
[![Swift Code](https://img.shields.io/badge/code in-Swift-orange.svg)](http://github.com/legoless/ViewModelable)
[![Build Status](https://travis-ci.org/Legoless/ViewModelable.svg)](https://travis-ci.org/legoless/ViewModelable)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/ViewModelable.svg?style=flat)](http://cocoadocs.org/docsets/ViewModelable/)
[![Pod Platform](http://img.shields.io/cocoapods/p/ViewModelable.svg?style=flat)](http://cocoadocs.org/docsets/ViewModelable/)
[![Pod License](http://img.shields.io/cocoapods/l/ViewModelable.svg?style=flat)](http://opensource.org/licenses/MIT)

ViewModelable is a simple and lightweight **MVVM** Swift implementation without any external dependencies for iOS. MVVM pattern is usually used with Reactive Extensions, but not necessary. View Model serves to separate any non-UI code away from View Controllers in this case. Each `UIViewController` should have a single instance of a corresponding view model. The logic in view model should always be able to create the initial state, regardless of the device state (even without an internet connection, the view model should be valid).

*ViewModelable supports Swift 3 since version 0.3.*

Each View Model should have input variables and output variables, which get populated based on input or local cache. Output variables usually should not be optional. **The concept is that output is always available for UIViewController to render, regardless of device state.**

View Model has 5 states:

- Initialized
- Setuped
- Loading
- Loaded
- Unloading

The state changes follow the next path:

*-> Initialized -> Setuped -> Loading -> Loaded -> Updates -> Unloading -> Setuped*

Loaded state can receive multiple updates.

View Model informs the view controller of state changes via observable pattern (similar to delegation). The methods received by the observer:

```swift
func viewModelDidSetup (viewModel: ViewModel)
func viewModelWillLoad (viewModel: ViewModel)
func viewModelDidLoad (viewModel: ViewModel)
func viewModelDidUpdate (viewModel: ViewModel, updates: [String : AnyObject])
func viewModelWillUnload (viewModel: ViewModel)
func viewModelDidUnload (viewModel: ViewModel)
```

You can also check view model's state with using `.state` property. State transitions are asynchronous, because view model usually works with async operations. The callback does not necessarily happen on main thread, so be sure to use dispatch correctly.

# Example

The example below implements a simple view model for a car.

```swift
class CarViewModel : ViewModel {
    // MARK: Input
    var make : String?
    var model : String?
    
    // MARK: Output
    private(set) var horsePower : Double = 0.0
    private(set) var weight : Double = 0.0
    
    func updateOutput() {
        guard let make = make, model = model else {
            horsePower = 0.0
            weight = 0.0
            
            return
        }
        if make == "Lamborgihini" && model == "Huracan" {
            horsePower = 782
            weight = 2100
        }
        else {
            horsePower = 120
            weight = 1100
        }
    }
}
```

A simple view controller implementation for the view model.

```swift
class CarViewController : ModelableViewController, ViewModelReferencable, ViewModelObservable {
    //
    // MARK: ViewModelReferencable
    //
    
    typealias T = CarViewModel
    
    var viewModel = T()
    
    var viewModelReference: ViewModel! {
        return viewModel
    }
    
    //
    // MARK: ViewModelObservable
    //
    func viewModelDidLoad (viewModel: ViewModel) {
        //
        // Update screen properties
        //
    }
}

```

Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**ViewModelable** is available under the **MIT** license. See [LICENSE](https://github.com/Legoless/ViewModelable/blob/master/LICENSE) file for more information.
