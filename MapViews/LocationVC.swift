//
//  SecondViewController.swift
//  MapViews
//
//  Created by Vidur Singh on 22/08/16.
//  Copyright © 2016 Vidur Singh. All rights reserved.
//

import UIKit
import MapKit


class LocationVC: UIViewController, UITableViewDelegate , UITableViewDataSource , MKMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    

    let addresses = ["Lodhi Rd, New Delhi, Delhi 110003","72, KK Birla Marg, Lodi Estate, New Delhi, Delhi 110003","Prithviraj Rd, Lodi Estate, Lodhi Estate, New Delhi, Delhi 110003"]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlaceMarkFromAddress(add)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        return UITableViewCell()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    func createAnnotationforLocation(location: CLLocation) {
        
        let annotations = MapAnnotations(coordinate: location.coordinate)
        map.addAnnotation(annotations)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(MapAnnotations) {
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.greenColor()
            annoView.animatesDrop = true
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation) {
            
            return nil
        }
        
        return nil
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            
            centerMapOnLocation(loc)
        }
    }
    
    func getPlaceMarkFromAddress(address: String) {
      
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, erroe: NSError?) in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    
                    self.createAnnotationforLocation(loc)
                    
                }
            }
        }
      
    }


}

