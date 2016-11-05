//
//  ViewController.swift
//  Mapy
//
//  Created by Monika Wojtasik on 05.11.2016.
//  Copyright © 2016 Monika Wojtasik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    var clLocationManager: CLLocationManager!
    
    @IBAction func onStart(_ sender: AnyObject) {
        clLocationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @IBAction func onStop(_ sender: AnyObject) {
        clLocationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    @IBAction func onClean(_ sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            clLocationManager = CLLocationManager()
            clLocationManager.delegate = self
            clLocationManager.requestWhenInUseAuthorization()
        }
        stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations.last!.coordinate
        let mySpeed = locations.last!.speed
        let spanD = mySpeed / 2000
        let span = MKCoordinateSpanMake(spanD, spanD)
        let area = MKCoordinateRegionMake(current, span)
        mapView.setRegion(area, animated: true)
        
        let pinezka = MKPointAnnotation()
        pinezka.coordinate = current
        mapView.addAnnotation(pinezka)
        
    }


}

