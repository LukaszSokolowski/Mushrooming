//
//  ViewController.swift
//  Mushrooming
//
//  Created by Łukasz Sokołowski on 17/09/2017.
//  Copyright © 2017 Łukasz Sokołowski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startPointButton: UIButton!
    
    let manager = CLLocationManager()
    var location: CLLocation = CLLocation()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startPointButton.layer.cornerRadius = 6.0
        mapView.layer.cornerRadius = 6.0
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        self.mapView.isZoomEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first!
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01,0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func setStartPoint(_ sender: UIButton) {
        let myStartPoint: MKPointAnnotation = MKPointAnnotation()
        myStartPoint.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        myStartPoint.title = "Punkt startowy"
        mapView.addAnnotation(myStartPoint)
    }
    
    
}

