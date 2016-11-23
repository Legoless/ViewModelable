//
//  CarViewController.swift
//  Demo
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import UIKit
import ViewModelable

class CarViewController: ModelableViewController, ViewModelObservable, ViewModelReferencable {
    
    //
    // MARK: Outlets
    //
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    
    //
    // MARK: ViewModelReferencable
    //
    
    typealias T = CarViewModel
    
    var viewModel = T()
    
    var viewModelReference: ViewModel! {
        return viewModel
    }
    
    //
    // MARK: ViewModelObservable
    //
    
    func viewModelDidSetup(_ viewModel: ViewModel) {
        //
        // Called once after viewDidLoad, view model will be in .setuped state.
        //
        
        update()
    }
    
    func viewModelDidLoad(_ viewModel: ViewModel) {
        //
        // Can be called anytime after viewWillAppear (asychronously) and can be called multiple times.
        //
        
        update()
    }
    
    func viewModelDidUpdate(_ viewModel: ViewModel, updates: [String : Any]) {
        //
        // Can be called anytime after viewModelDidLoad is called and can be called multiple times.
        //
    }
    
    func viewModelDidUnload(_ viewModel: ViewModel) {
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

