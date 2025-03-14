# ViewModelable

ViewModelable is a simple and lightweight **Model View ViewModel** pattern implementation in Swift without any external dependencies for iOS. MVVM pattern is usually used with Reactive Extensions for bindings, but not always. View Model serves to separate any non-UI code away from View Controllers in this case. Each `UIViewController` is backed by a single instance of corresponding view model. Business logic in view model should always be able to create the initial state, regardless of the device state (even without an internet connection, the view model should be valid).

Each View Model should have input variables and output variables, which get populated based on input or local cache. Output variables usually should not be optional.

**The idea is that all outputs on `ViewModel` are always defined and initialized for `UIViewController` to be displayed, independent of device state, network connection or similar error states.** It also allows of easy unit testing for the view models.

View Model has 5 states:

- Initialized
- Setuped
- Loading
- Loaded
- Unloading

The state changes follow the next path:

Initialized -> Setuped -> Loading -> Loaded -> Updates -> Unloading -> Setuped*

Loaded state can receive multiple callbacks, but the ViewModel cannot proceed back to initialized state.

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

# Installation

Add `https://github.com/legoless/ViewModelable` as package to your project using Swift Package Manager.

# Example

The example below implements a simple view model for a car, without usage of a specific model object.

```swift
import ViewModelable

@MainActor
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
@MainActor
class CarViewController : ModelableViewController<CarViewModel>, ViewModelObservable {
    //
    // MARK: ViewModelObservable
    //
    func viewModelDidLoad (viewModel: ViewModel) {
        //
        // Update screen properties
        //
        
        // self.textLabel.text = "\(self.viewModel.horsePower) kW"
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
