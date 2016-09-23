//
//  MapAnnotations.swift
//  MapViews
//
//  Created by Vidur Singh on 24/08/16.
//  Copyright © 2016 Vidur Singh. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotations: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        
        self.coordinate = coordinate
    }
}
