//
//  MapViewVC.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewVC: UIViewController {
    
    let locationManager = CLLocationManager()
    var islocationUpdated:Bool = false
    
    @IBOutlet weak var map: MKMapView!
    var myLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
        if let coor = map.userLocation.location?.coordinate{
            map.setCenter(coor, animated: true)
        }
        addLongPressGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        map.showsUserLocation = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        map.showsUserLocation = false
    }
    
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(self.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.map.addGestureRecognizer(longPressRecogniser)
    }
    
    @objc func handleLongPress(_ gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .began{
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.location(in: self.map)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        self.resetTracking()
        self.map.addAnnotation(annot)
        self.centerMap(touchMapCoordinate)
        let vc = storyboard?.instantiateViewController(identifier: VC.kWeatherViewVC) as! WeatherViewVC
        vc.selectedCordinates = touchMapCoordinate
        self.present(vc, animated: true,completion: nil)
    }
    
    func resetTracking(){
        if (map.showsUserLocation){
            map.showsUserLocation = false
            self.map.removeAnnotations(map.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMap(_ center:CLLocationCoordinate2D){
        self.saveCurrentLocation(center)
        
        let spanX = 0.05
        let spanY = 0.05
        
        let newRegion = MKCoordinateRegion(center:center , span: MKCoordinateSpan(latitudeDelta: spanX, longitudeDelta: spanY))
        map.setRegion(newRegion, animated: true)
    }
    
    func saveCurrentLocation(_ center:CLLocationCoordinate2D){
        let message = "\(center.latitude) , \(center.longitude)"
        print(message)
        myLocation = center
    }
}
extension MapViewVC:CLLocationManagerDelegate,MKMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !(islocationUpdated){
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        centerMap(locValue)
            islocationUpdated = true
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "pin"
        var view : MKPinAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.pinColor =  .purple
        return view
    }
    
}
