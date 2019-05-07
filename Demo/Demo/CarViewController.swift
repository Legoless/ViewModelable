//
//  CarViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit
import ViewModelable

class CarViewController: ModelableViewController<CarViewModel> {
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    
    //
    // MARK: - ViewModelObservable
    //
    
    override func viewModelDidSetup(viewModel: CarViewModel) {
        super.viewModelDidSetup(viewModel: viewModel)
        
        //
        // Called once after viewDidLoad, view model will be in .setuped state.
        //
        
        print("[+] ViewModel: \(viewModel) did setup.")
        
        update()
    }
    
    override func viewModelDidLoad(viewModel: CarViewModel) {
        super.viewModelDidLoad(viewModel: viewModel)
        //
        // Can be called anytime after viewWillAppear (asychronously) and can be called multiple times.
        //
        
        print("[+] ViewModel: \(viewModel) did load.")
        
        update()
    }
    
    override func viewModelDidUpdate(viewModel: CarViewModel, updates: [String : Any]) {
        super.viewModelDidUpdate(viewModel: viewModel, updates: updates)
        
        //
        // Can be called anytime after viewModelDidLoad is called and can be called multiple times.
        //
    }
    
    override func viewModelDidUnload(viewModel: CarViewModel) {
        super.viewModelDidUnload(viewModel: viewModel)
        //
        // Will be called after viewWillDisappear, view model transitioned to .setuped state.
        //
    }
    
    //
    // MARK: Private Methods
    //
    
    func update() {
        topLabel.text = viewModel.carDescription
        bottomLabel.text = viewModel.engineDescription
        
        activityIndicatorView.isHidden = !viewModel.loading
    }
}

