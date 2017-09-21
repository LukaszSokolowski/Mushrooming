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
    
    let locationManager = CLLocationManager()
    var location: CLLocation = CLLocation()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonCornerRadius = 6.0
        let mapViewCornerRadius = 6.0
        startPointButton.layer.cornerRadius = CGFloat(buttonCornerRadius)
        mapView.layer.cornerRadius = CGFloat(mapViewCornerRadius)
    }
    
    func locationManagerConfiguration() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func mapViewConfiguration() {
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.userTrackingMode = .followWithHeading
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

