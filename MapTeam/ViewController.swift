//
//  ViewController.swift
//  MapTeam
//
//  Created by Louis Viart on 22/01/2019.
//  Copyright © 2019 LouisViart. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let currentUserLocation = locations.last {
            currentLocation = currentUserLocation

            let center = CLLocationCoordinate2D(
                latitude: currentUserLocation.coordinate.latitude,
                longitude: currentUserLocation.coordinate.longitude
            )
            let region = MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )

            mapView.setRegion(region, animated: true)

            let userAnnotation = MKPointAnnotation()

            userAnnotation.coordinate = currentUserLocation.coordinate
            userAnnotation.title = "It's Me"


            mapView.addAnnotation(userAnnotation)

            locationManager?.stopUpdatingLocation()
        }
        
    }

    @IBAction func tapOnMap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let locationSelectedInView = sender.location(in: mapView)
        }
    }
}

