//
//  MMViewController.swift
//  MetroMesh
//
//  Created by Oludemi, Oluwabori (BANK) on 2/1/17.
//  Copyright © 2017 Oluwabori Oludemi. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class MMViewController: UIViewController {
    
    var locationManager:CLLocationManager!
    let stations = [MetroStations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "stations", ofType: "json") {
            do  {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
//                guard let stations = json as? [String: [Any]] else {
//                        return
//                }
                
                if let stations = json as? [String: [Any]] {
                    if let stationsArray = stations["Stations"]{
                        
                    }
                }
                
                print(json)
            } catch let error{
                
                print(error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func currentLocationClicked(_ sender: UIButton) {
        getCurrentLocation()
    }
    
    func getCurrentLocation()  {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            debugPrint("Allowed to get current location")
            locationManager.startUpdatingLocation()
        }
        else{
            debugPrint("Whoops, you didn't enable location")
        }
    }
    
}

extension MMViewController: CLLocationManagerDelegate{
    /*
     *  locationManager:didUpdateLocations:
     *
     *  Discussion:
     *    Invoked when new locations are available.  Required for delivery of
     *    deferred locations.  If implemented, updates will
     *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
     *
     *    locations is an array of CLLocation objects in chronological order.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            debugPrint("Error fetching location from [CLLocation]")
            return
        }
        print("Lat: \(location.coordinate.latitude) --- Lon: \(location.coordinate.longitude)")
    }
}
