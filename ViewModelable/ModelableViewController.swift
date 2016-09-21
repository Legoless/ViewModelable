//
//  ModelableViewController.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 06/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

open class ModelableViewController : UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModelController = self as? ViewModelReferencable, let viewModel = viewModelController.viewModelReference {
            
            if let viewController = self as? ViewModelObservable {
                viewModel.observer = viewController
                
                for childViewModel in viewModel.childViewModels {
                    childViewModel.observer = viewController
                }
            }
            
            viewModel.setup()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModelController = self as? ViewModelReferencable, let viewModel = viewModelController.viewModelReference {
            viewModel.load()
        }
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let viewModelController = self as? ViewModelReferencable, let viewModel = viewModelController.viewModelReference {
            viewModel.unload()
        }
    }
}
