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
    
    override func startSetup() {
        super.startSetup()
        
        //
        // View model should handle data, here we just pull a car if it was not set.
        //
        loading = true
    }
    
    override func startLoading() {
        loading = true
        carDescription = "Loading..."
        engineDescription = ""
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.loading = false
            
            if self.car == nil {
                self.car = Car.lamborghiniAvendator()
            }
            
            //
            // Call to finish loading, to ensure state transition is correct.
            //
            self.finishLoading()
        }
        
    }
    
    override func updateOutput() {
        
        //
        // This method is called multiple times during state transitions and 
        //  should just set output variables in a synchronous way.
        //
        
        if let car = car {
            carDescription = "\(car.make) \(car.model)"
            engineDescription = "\(car.engine.displacement) cc, \(car.engine.brakeHorsepower) BHP"
        }
        else if loading == true {
            carDescription = "Loading..."
            engineDescription = ""
        }
        else {
            carDescription = "Unknown"
            engineDescription = ""
        }
    }
}
