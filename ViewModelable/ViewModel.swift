//
//  ViewModel.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 04/03/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

///
/// View Model state representation
///
public enum State : UInt {
    case initialized    // View Model was initialized (first state). Setup should be called, before output is available.
    case setuped        // View Model was setuped. Setup was called, but data was not loaded yet. Output is should be available.
    case loading        // View Model is currently refreshing data, offline data should be available.
    case loaded         // View Model is loaded and subscribed, it will emit updates.
    case unloading      // View Model was unloaded and will transition to Setuped state.
}

///
/// Abstract Generic View model object, abstract
///
open class ViewModel: NSObject {
    
    //
    // MARK: Public Properties
    //
    
    // Observer of view model, usually a controller or a view
    open weak var observer : ViewModelObservable?
    
    // When view model was initialized
    open fileprivate(set) var initializationDate = Date()
    
    // When view model was loaded
    open fileprivate(set) var loadDate : Date?
    
    open fileprivate(set) var state = State.initialized
    
    //
    // Child view models that are contained
    //
    open fileprivate(set) var childViewModels : [ViewModel] = [ViewModel]()
    
    //
    // MARK: Initialization
    //
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //
    // MARK: Public API for interacting with view model, only call these methods outside View Model.
    //
    
    /*!
     Should be called in View Will Appear, this will setup the defaults and after this state, all input variables
     should be prepared. Input variables usually should not have Live Realm objects, but their snapshots.
     */
    public final func setup () {
        if state != .initialized {
            return
        }
        
        state = .setuped
        
        startSetup()
        updateOutput()
        
        //
        // Setup child view models
        //
        
        for viewModel in childViewModels {
            viewModel.setup()
        }
        
        if let observer = observer {
            observer.viewModelDidSetup(self)
        }
    }
    
    /*!
     Begins loading view model, starting by root subscription, should be called in view did appear.
     */
    public final func load() {
        if state != .setuped {
            return
        }
        
        state = .loading
        
        //
        // Update output to ensure loading state.
        //
        
        if let observer = observer {
            observer.viewModelWillLoad(self)
        }
        
        //
        // Load child view models
        //
        
        for viewModel in childViewModels {
            viewModel.load()
        }
        
        startLoading()
    }
    
    //
    // MARK: Public Methods
    //
    
    public final func addChildViewModel(_ viewModel: ViewModel) {
        if (childViewModels.index(where: { $0 === viewModel }) != nil) {
            return
        }
        
        childViewModels.append(viewModel)
    }
    
    /*!
     Should be called when view disappears, this will clean state of view model.
     */
    public final func unload() {
        if state != .loaded {
            return
        }
        
        state = .unloading
        
        if let observer = observer {
            observer.viewModelWillUnload(self)
        }
        
        //
        // Load child view models
        //
        
        for viewModel in childViewModels {
            viewModel.unload()
        }
        
        startUnloading()
    }
    
    //
    // Finish loading must be called by a subclass when loading is completed, so the view model state is correctly set.
    // Observer is notified of model successfully loading. Output variables are reset to ensure the most correct state.
    //
    public final func finishLoading() {
        
        state = .loaded
        loadDate = Date()
        
        updateOutput()
        
        if let observer = self.observer {
            observer.viewModelDidLoad(self)
        }
    }
    
    /*!
     Finish unloading must be called by a subclass to correctly transition back into Setuped state.
     */
    public final func finishUnloading() {
        
        state = .setuped
        loadDate = nil
        
        updateOutput()
        
        if let observer = observer {
            observer.viewModelDidUnload(self)
        }
    }
    
    //
    // MARK: Public Methods that should be overriden by subclass for correct life-cycle.
    //
    
    /*!
     Should be overriden, if there are any input defaults that should be set by subclass as the setup
     of the view model.
     */
    open func startSetup () {
        
    }
    
    /*!
     Must be overriden by a subclass to correctly start loading output variables, if view model is
     doing custom loading. Subclass should not call super's startLoading, unless specifically required.
     */
    open func startLoading() {
        finishLoading()
    }
    
    /*!
     Must be overriden by a subclass to correctly start unloading output variables. This is to clean
     Memory up if the corresponding view controller is not on screen.
     */
    open func startUnloading() {
        finishUnloading()
    }
    
    /*!
     Must be overriden by a subclass to correctly update output. This method should take any input
     and provide output variables.
     */
    open func updateOutput() {
    }
}
