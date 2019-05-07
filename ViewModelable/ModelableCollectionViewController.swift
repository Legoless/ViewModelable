//
//  ModelableCollectionViewController.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 29/08/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

import UIKit

open class ModelableCollectionViewController <T : ViewModel> : UICollectionViewController, ViewModelObservable {
    public var viewModel : T = T()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.observer = self
        
        for childViewModel in viewModel.childViewModels {
            childViewModel.observer = self
        }
        
        viewModel.setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.unload()
    }
    
    public func viewModelDidSetup (_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelDidSetup(viewModel: viewModel)
    }
    
    public func viewModelWillLoad (_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelWillLoad(viewModel: viewModel)
    }
    
    public func viewModelDidLoad (_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelDidLoad(viewModel: viewModel)
    }
    
    public func viewModelDidUpdate (_ viewModel: ViewModel, updates: [String : Any]) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelDidUpdate(viewModel: viewModel, updates: updates)
    }
    
    public func viewModelWillUnload (_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelWillUnload(viewModel: viewModel)
    }
    
    public func viewModelDidUnload (_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? T else {
            return
        }
        viewModelDidUnload(viewModel: viewModel)
    }
    
    open func viewModelDidSetup (viewModel: T) {
        
    }
    
    open func viewModelWillLoad (viewModel: T) {
        
    }
    
    open func viewModelDidLoad (viewModel: T) {
        
    }
    
    open func viewModelDidUpdate (viewModel: T, updates: [String : Any]) {
        
    }
    
    open func viewModelWillUnload (viewModel: T) {
        
    }
    
    open func viewModelDidUnload (viewModel: T) {
        
    }
}
