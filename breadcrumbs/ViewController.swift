//
//  ViewController.swift
//  breadcrumbs
//
//  Created by Mahmoud Lababidi on 3/1/15.
//  Copyright (c) 2015 Spam Eggs. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
//        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateTimer(){
        self.locationManager.startUpdatingLocation()
        println("update")
    }


    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println(manager.location)
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                println("Error:" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                
                let pm = placemarks[0] as CLPlacemark
                
                self.displayLocationInfo(pm)
                
                
            }else {
                
                println("Error with data")
                
            }
            
        })
        
    }
    
    
    
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        
        
        self.locationManager.stopUpdatingLocation()
        
        
        
        println(placemark.locality)
        
        println(placemark.postalCode)
        
        println(placemark.administrativeArea)
        
        println(placemark.country)
        
        
        
    }
    
    
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error: " + error.localizedDescription)
        
    }

    
    
}

