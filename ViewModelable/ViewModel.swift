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
    case Initialized    // View Model was initialized (first state). Setup should be called, before output is available.
    case Setuped        // View Model was setuped. Setup was called, but data was not loaded yet. Output is should be available.
    case Loading        // View Model is currently refreshing data, offline data should be available.
    case Loaded         // View Model is loaded and subscribed, it will emit updates.
    case Unloading      // View Model was unloaded and will transition to Setuped state.
}

///
/// Abstract Generic View model object, abstract
///
public class ViewModel: NSObject {
    
    //
    // MARK: Public Properties
    //
    
    // Observer of view model, usually a controller or a view
    public weak var observer : ViewModelObservable?
    
    // When view model was initialized
    public private(set) var initializationDate = NSDate()
    
    // When view model was loaded
    public private(set) var loadDate : NSDate?
    
    public private(set) var state = State.Initialized
    
    //
    // Child view models that are contained
    //
    public private(set) var childViewModels : [ViewModel] = [ViewModel]()
    
    //
    // MARK: Initialization
    //
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //
    // MARK: Public API for interacting with view model, only call these methods outside View Model.
    //
    
    /*!
     Should be called in View Will Appear, this will setup the defaults and after this state, all input variables
     should be prepared. Input variables usually should not have Live Realm objects, but their snapshots.
     */
    public final func setup () {
        if state != .Initialized {
            return
        }
        
        state = .Setuped
        
        setDefaults()
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
        if state != .Setuped {
            return
        }
        
        state = .Loading
        
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
    
    public final func addChildViewModel(viewModel: ViewModel) {
        if (childViewModels.indexOf({ $0 === viewModel }) != nil) {
            return
        }
        
        childViewModels.append(viewModel)
    }
    
    /*!
     Should be called when view disappears, this will clean state of view model.
     */
    public final func unload() {
        if state != .Loaded {
            return
        }
        
        state = .Unloading
        
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
        
        state = .Loaded
        loadDate = NSDate()
        
        updateOutput()
        
        if let observer = self.observer {
            observer.viewModelDidLoad(self)
        }
    }
    
    /*!
     Finish unloading must be called by a subclass to correctly transition back into Setuped state.
     */
    public final func finishUnloading() {
        
        state = .Setuped
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
     Should be overriden, if there are any input defaults that should be set by subclass.
     */
    public func setDefaults () {
        
    }
    
    /*!
     Must be overriden by a subclass to correctly start loading output variables, if view model is
     doing custom loading.
     */
    public func startLoading() {
        finishLoading()
    }
    
    public func startUnloading() {
        finishUnloading()
    }
    
    /*!
     Must be overriden by a subclass to correctly update output. This method should take any input
     and provide output variables.
     */
    public func updateOutput() {
    }
}
