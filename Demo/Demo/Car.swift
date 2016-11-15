//
//  Car.swift
//  Demo
//
//  Created by Dal Rupnik on 09/07/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

//
// MARK: Definition
//

// A simple car model that describes car specifications. Does not represent a real model, rather an approximation,
// for view model example purpose.
//
// Data specification taken from https://www.quora.com/What-do-the-specifications-of-a-car-actually-mean
//

enum BodyType : String {
    case mini, small, medium, large, executive, luxury, coupe, roadster, stationWagon, minivan, SUV, pickup
}

//
// Car Model
//
struct Car {
    var make : String
    var model : String
    var body : BodyType
    var doorCount : UInt
    
    var engine : Engine
    var drivetrain: Drivetrain
    var transmission : Transmission
}

enum Drivetrain : String {
    case fwd, rwd, awd
}

enum Transmission : String {
    case manual, automatic
}

//
// Engine specifications
//

enum EngineType : String {
    case inLine, vType, horizontal
}

struct Engine {
    var type : EngineType
    var displacement : UInt         // In cc
    var brakeHorsepower : UInt      // In BHP
    var torque : Double             // In N/m
    var turbocharged : Bool
}

//
// MARK: Factory methods
//

extension Car {
    static func lamborghiniAvendator() -> Car {
        let engine = Engine(type: .vType, displacement: 6498, brakeHorsepower: 690, torque: 689, turbocharged: false)
        
        return Car(make: "Lamborghini", model: "Aventador", body: .coupe, doorCount: 2, engine: engine, drivetrain: .awd, transmission: .automatic)
    }
    
    static func fordFocusRs() -> Car {
        let engine = Engine(type: .inLine, displacement: 2298, brakeHorsepower: 345, torque: 475, turbocharged: true)
        
        return Car(make: "Ford", model: "Focus RS", body: .small, doorCount: 4, engine: engine, drivetrain: .awd, transmission: .manual)
    }
}
