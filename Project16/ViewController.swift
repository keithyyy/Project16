//
//  ViewController.swift
//  Project16
//
//  Created by Keith Crooc on 2021-10-13.
//

// Challenge
// 1. Try typecasting the return value from dequeueReusableAnnotationView() so that it's an MKPinAnnotationView. Once that’s done, change the pinTintColor property to your favorite UIColor. ✅

// 2. Add a UIAlertController that lets users specify how they want to view the map. There's a mapType property that draws the maps in different ways. For example, .satellite gives a satellite view of the terrain. ✅

// 3. Modify the callout button so that pressing it shows a new view controller with a web view, taking users to the Wikipedia entry for that city.

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
//        adding our capital city pins to our map
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself")
        
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        
//        Add a UIAlertController to let users change the view of the map
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(changeMapType))
        
    
    }
    
    //        when a pin gets tapped, to add an annotation with our "Info" displaying
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        //        challenge 1 - typecast this as MKPinAnnotationView
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            changing the pin color
            annotationView?.pinTintColor = .blue
            annotationView?.canShowCallout = true
            
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
        } else {
            annotationView?.annotation = annotation
        }
//        challenge 1 - typecast this as MKPinAnnotationView
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    @objc func changeMapType() {
        
        let mapAC = UIAlertController(title: "Map type", message: "Choose Map View", preferredStyle: .alert)
        
        mapAC.addAction(UIAlertAction(title: "Standard", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        
        
        mapAC.addAction(UIAlertAction(title: "Satellite", style: .default, handler: {
            [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        
        present(mapAC, animated: true)
    }
    
    

}

