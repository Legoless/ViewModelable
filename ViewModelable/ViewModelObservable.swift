//
//  ViewModelObservable.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 20/04/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

/*!
 *  Used to cast and access view model reference
 */
public protocol ViewModelReferencable {
    var viewModelReference : ViewModel! { get }
}

/*!
 *  Protocol used in classes that support View Models
 */
public protocol ViewModelable : ViewModelReferencable {
    associatedtype T : ViewModel
    
    var viewModel : T { get }
}

/*!
 *  Both methods are not guaranteed to be called back on the same thread as requested,
 *  so be sure to use a dispatch when necessary.
 */
public protocol ViewModelObservable : NSObjectProtocol {
    
    /*!
     Called after model is successfully initialized with input data.
     
     - parameter viewModel: setuped view model
     */
    func viewModelDidSetup (viewModel: ViewModel)
    
    /*!
     Called after calling setup method, when root subscriptions of the view model begin loading.
     View model should be in offline state, when this method is called, so it is safe to
     display objects from View Model. Usually entire view controller should be reloaded at this point.
     
     All available output variables will be set up, but could change when model loads.
     
     - parameter viewModel: view model to be loaded
     */
    func viewModelWillLoad (viewModel: ViewModel)
    
    /*!
     Called when view model has finished loading and all output variables are available
     to be displayed. This method does not ensure all child view models had finished loading,
     as those models should be specifically observed. It can be called multiple times.
     
     - parameter viewModel: loaded view model
     */
    func viewModelDidLoad (viewModel: ViewModel)
    
    /*!
     Call to observer when view model updated a part of data (not entire set). The method can
     be called multiple times.
     
     - parameter viewModel: updated view model
     */
    func viewModelDidUpdate (viewModel: ViewModel, updates: [String : AnyObject])
    
    /*!
     View model will transition back from Loaded state to Setuped state, since unload was called.
     Subscriptions and observers will be removed after this.
     
     - parameter viewModel: view model to be unloaded
     */
    func viewModelWillUnload (viewModel: ViewModel)
    
    /*!
     View model transitioned back to setuped state and objects are not available anymore.
     
     - parameter viewModel: unloaded view model
     */
    func viewModelDidUnload (viewModel: ViewModel)
}

//
// MARK: Default implementations
//

extension ViewModelObservable {
    
    public func viewModelDidSetup (viewModel: ViewModel) {
        
    }
    
    public func viewModelWillLoad (viewModel: ViewModel) {
        
    }
    
    public func viewModelDidLoad (viewModel: ViewModel) {
        
    }
    
    public func viewModelDidUpdate (viewModel: ViewModel, updates: [String : AnyObject]) {
        
    }
    
    public func viewModelWillUnload (viewModel: ViewModel) {
        
    }
    
    public func viewModelDidUnload (viewModel: ViewModel) {
        
    }
}