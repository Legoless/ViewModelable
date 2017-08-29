//
//  ModelableTableViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 29/08/2017.
//  Copyright © 2017 Unified Sense. All rights reserved.
//

import UIKit

open class ModelableTableViewController <T : ViewModel> : UITableViewController {
    public var viewModel : T = T()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewController = self as? ViewModelObservable {
            viewModel.observer = viewController
            
            for childViewModel in viewModel.childViewModels {
                childViewModel.observer = viewController
            }
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
}
