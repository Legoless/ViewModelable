//
//  ViewModelObservable.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 20/04/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

/*!
 *  Both methods are not guaranteed to be called back on the same thread as requested,
 *  so be sure to use a dispatch when necessary.
 */
@MainActor
public protocol ViewModelObservable : AnyObject {
    
    /*!
     Called after model is successfully initialized with input data.
     
     - parameter viewModel: setuped view model
     */
    func viewModelDidSetup (_ viewModel: ViewModel)
    
    /*!
     Called after calling setup method, when root subscriptions of the view model begin loading.
     View model should be in offline state, when this method is called, so it is safe to
     display objects from View Model. Usually entire view controller should be reloaded at this point.
     
     All available output variables will be set up, but could change when model loads.
     
     - parameter viewModel: view model to be loaded
     */
    func viewModelWillLoad (_ viewModel: ViewModel)
    
    /*!
     Called when view model has finished loading and all output variables are available
     to be displayed. This method does not ensure all child view models had finished loading,
     as those models should be specifically observed. It can be called multiple times.
     
     - parameter viewModel: loaded view model
     */
    func viewModelDidLoad (_ viewModel: ViewModel)
    
    /*!
     Call to observer when view model updated a part of data (not entire set). The method can
     be called multiple times.
     
     - parameter viewModel: updated view model
     */
    func viewModelDidUpdate (_ viewModel: ViewModel, updates: [String : Any])
    
    /*!
     View model will transition back from Loaded state to Setuped state, since unload was called.
     Subscriptions and observers will be removed after this.
     
     - parameter viewModel: view model to be unloaded
     */
    func viewModelWillUnload (_ viewModel: ViewModel)
    
    /*!
     View model transitioned back to setuped state and objects are not available anymore.
     
     - parameter viewModel: unloaded view model
     */
    func viewModelDidUnload (_ viewModel: ViewModel)
}

//
// MARK: Default implementations, so they are optional.
//

@MainActor
extension ViewModelObservable {
    
    public func viewModelDidSetup (_ viewModel: ViewModel) {
        
    }
    
    public func viewModelWillLoad (_ viewModel: ViewModel) {
        
    }
    
    public func viewModelDidLoad (_ viewModel: ViewModel) {
        
    }
    
    public func viewModelDidUpdate (_ viewModel: ViewModel, updates: [String : Any]) {
        
    }
    
    public func viewModelWillUnload (_ viewModel: ViewModel) {
        
    }
    
    public func viewModelDidUnload (_ viewModel: ViewModel) {
        
    }
}
