//
//  IntentHandler.swift
//  Extension
//
//  Created by Lasse Silkoset on 24/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

import Intents
import UIKit

class IntentHandler: INExtension, INListRideOptionsIntentHandling, INRequestRideIntentHandling, INGetRideStatusIntentHandling, INCancelRideIntentHandling, INSendRideFeedbackIntentHandling {
    
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
    func handle(intent: INListRideOptionsIntent, completion: @escaping (INListRideOptionsIntentResponse) -> Void) {
        
        let result = INListRideOptionsIntentResponse(code: .success, userActivity: nil)
        let mini = INRideOption(name: "Mini Cooper", estimatedPickupDate: Date(timeIntervalSinceNow: 1000))
        let accord = INRideOption(name: "Honda Accord", estimatedPickupDate: Date(timeIntervalSinceNow: 800))
        let ferrari = INRideOption(name: "Ferrari F430", estimatedPickupDate: Date(timeIntervalSinceNow: 300))
        ferrari.disclaimerMessage = "Bad for the environment"
        
        result.expirationDate = Date(timeIntervalSinceNow: 3600)
        result.rideOptions = [mini, accord, ferrari]
        
        completion(result)
    }
    
    func handle(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        
        let result = INRequestRideIntentResponse(code: .success, userActivity: nil)
        let status = INRideStatus()
        
        status.rideIdentifier = "abc123"
        status.pickupLocation = intent.pickupLocation
        status.dropOffLocation = intent.dropOffLocation
        
        status.phase = INRidePhase.confirmed
        
        status.estimatedPickupDate = Date(timeIntervalSinceNow: 900)
        
        let vehicle = INRideVehicle()
        
        let image = UIImage(named: "car")!
        let data = image.pngData()!
        vehicle.mapAnnotationImage = INImage(imageData: data)
        
        vehicle.location = intent.dropOffLocation!.location
        
        result.rideStatus = status
        
        completion(result)
    }
    
    func handle(intent: INGetRideStatusIntent, completion: @escaping (INGetRideStatusIntentResponse) -> Void) {
        
        let result = INGetRideStatusIntentResponse(code: .success, userActivity: nil)
        completion(result)
    }
    
    func startSendingUpdates(for intent: INGetRideStatusIntent, to observer: INGetRideStatusIntentResponseObserver) {
        
    }
    
    func stopSendingUpdates(for intent: INGetRideStatusIntent) {
        
    }
    
    func handle(cancelRide intent: INCancelRideIntent, completion: @escaping (INCancelRideIntentResponse) -> Void) {
        
    }
    
    func handle(sendRideFeedback sendRideFeedbackintent: INSendRideFeedbackIntent, completion: @escaping (INSendRideFeedbackIntentResponse) -> Void) {
        
    }
    
    func resolvePickupLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        
        let result: INPlacemarkResolutionResult
        
        if let requestetLocation = intent.pickupLocation {
            result = INPlacemarkResolutionResult.success(with: requestetLocation)
        } else {
            result = INPlacemarkResolutionResult.needsValue()
        }
        
        completion(result)
    }
    
    func resolveDropOffLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        
        let result: INPlacemarkResolutionResult
        
        if let requestedLocation = intent.dropOffLocation {
            result = INPlacemarkResolutionResult.success(with: requestedLocation)
        } else {
            result = INPlacemarkResolutionResult.needsValue()
        }
        
        completion(result)
    }
}

