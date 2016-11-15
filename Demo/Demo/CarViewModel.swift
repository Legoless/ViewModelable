//
//  CarViewModel.swift
//  Demo
//
//  Created by Dal Rupnik on 09/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation

class CarViewModel : ViewModel {
    //
    // MARK: Input of the view model, must be
    //
    
    var car : Car?
    
    //
    // MARK: Output of view model, must be populated at all times, so screen can be
    //
    
    private(set) var loading : Bool = false
    
    private(set) var carDescription = ""
    private(set) var engineDescription = ""
}
