//
//  ModelableViewController.swift
//  ViewModelable
//
//  Created by Dal Rupnik on 06/06/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit

public class ModelableViewController : UIViewController {
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        if let viewModelController = self as? ViewModelReferencable, viewModel = viewModelController.viewModelReference {
            
            if let viewController = self as? ViewModelObservable {
                viewModel.observer = viewController
                
                for childViewModel in viewModel.childViewModels {
                    childViewModel.observer = viewController
                }
            }
            
            viewModel.setup()
        }
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModelController = self as? ViewModelReferencable, viewModel = viewModelController.viewModelReference {
            viewModel.load()
        }
    }

    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if let viewModelController = self as? ViewModelReferencable, viewModel = viewModelController.viewModelReference {
            viewModel.unload()
        }
    }
}