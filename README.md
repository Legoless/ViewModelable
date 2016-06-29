# ViewModelable

ViewModelable is a simple and lightweight **MVVM** Swift implementation without any external dependencies for iOS. MVVM pattern is usually used with Reactive Extensions, but not necessary. View Model serves to separate any non-UI code away from View Controllers in this case. Each `UIViewController` should have a single instance of a corresponding view model. The logic in view model should always be able to create the initial state, regardless of the device state (even without an internet connection, the view model should be valid).

Each View Model should have input variables and output variables, which get populated based on input or local cache. Output variables usually should not be optional, to avoid odd screen state.

View Model has several different states:

- Initialized
- Setuped
- Loading
- Loaded

View Model informs the view controller of state changes via observable pattern (similar to delegation). The methods received by the observer:

```swift
func viewModelDidSetup (viewModel: ViewModel)
func viewModelWillLoad (viewModel: ViewModel)
func viewModelDidLoad (viewModel: ViewModel)
func viewModelDidUpdate (viewModel: ViewModel, updates: [String : AnyObject])
func viewModelWillUnload (viewModel: ViewModel)
func viewModelDidUnload (viewModel: ViewModel)
```

You can also check view model's state with using `.state` property. State transitions are asynchronous, because view model usually works with async operations. The callback does not necessarily happen on main thread, so be sure to dispatch correctly.

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

A view controller implementation for the view model.

```swift
class CarViewController : ModelableViewController {
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
