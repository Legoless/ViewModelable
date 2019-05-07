//
//  ModelableViewController.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 06/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

open class ModelableViewController <T : ViewModel> : UIViewController, ViewModelObservable {
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
    
    open func viewModelDidSetup (_ viewModel: T) {
        
    }
    
    open func viewModelWillLoad (_ viewModel: T) {
        
    }
    
    open func viewModelDidLoad (_ viewModel: T) {
        
    }
    
    open func viewModelDidUpdate (_ viewModel: T, updates: [String : Any]) {
        
    }
    
    open func viewModelWillUnload (_ viewModel: T) {
        
    }
    
    open func viewModelDidUnload (_ viewModel: T) {
        
    }
}
