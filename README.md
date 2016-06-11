# ViewModelable

ViewModelable is a simple and lightweight **View Model** implementation without any external dependencies. MVVM pattern is usually used with Reactive Extensions, but not necessary. View Model serves to separate any non-UI code away from View Controllers in this case. Each `UIViewController` should have a single instance of a corresponding view model. The logic in view model should always be able to create the initial state, regardless of the device state (even without an internet connection, the view model should be valid).

View Model has several different states:

- Initialized
- Setupped
- Loading
- Loaded

View Model informs the view controller of state changes via observable pattern (similar to delegation). The methods received by the observer:

```
func viewModelDidSetup (viewModel: ViewModel)
func viewModelWillLoad (viewModel: ViewModel)
func viewModelDidLoad (viewModel: ViewModel)
func viewModelDidUpdate (viewModel: ViewModel, updates: [String : AnyObject])
func viewModelWillUnload (viewModel: ViewModel)
func viewModelDidUnload (viewModel: ViewModel)
```

You can also check view model's state with using `.state` property. State transitions are asynchronous, because view model usually works with async operations. The callback does not necesserily happen on main thread.


Contact
======

Dal Rupnik

- [legoless](https://github.com/legoless) on **GitHub**
- [@thelegoless](https://twitter.com/thelegoless) on **Twitter**
- [dal@unifiedsense.com](mailto:dal@unifiedsense.com)

License
======

**ViewModelable** is available under the **MIT** license. See [LICENSE](https://github.com/Legoless/ViewModelable/blob/master/LICENSE) file for more information.
