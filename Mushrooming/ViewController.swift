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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
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
        
        self.mapView.showsUserLocation = true
        self.mapView.mapType = MKMapType(rawValue: 0)!
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
        
        self.mapView.isZoomEnabled = true
        self.mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRender = MKPolylineRenderer(overlay: overlay)
        lineRender.strokeColor = UIColor.blue
        lineRender.lineWidth = 3
        return lineRender
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

