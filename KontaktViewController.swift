//
//  KontaktViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 6.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class Destinacija: NSObject {
    
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name: String, location: CLLocationCoordinate2D, zoom: Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}


class KontaktViewController: UIViewController,CLLocationManagerDelegate {

    var locManager = CLLocationManager()
    var mojaPozlong:Double = 0.0
    var mojaPozlat:Double = 0.0
    
    func pokreniSvojuPoziciju(){
        var trenutnaPozicija = CLLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Authorized){
            
            trenutnaPozicija = locManager.location!
            
        }
        print("Stampaj lokaciju")
        mojaPozlong = trenutnaPozicija.coordinate.longitude
        mojaPozlat = trenutnaPozicija.coordinate.latitude
        print(trenutnaPozicija.coordinate.longitude)
    }
    
    
    
    
    var mapView: GMSMapView?
    
    var currentDestination: Destinacija?
    
    
    //let krajnjaDestinacija = [Destinacija(name: "Mi smo ovde", location: CLLocationCoordinate2DMake(44.8114168,20.4581917), zoom: 14)]
    let krajnjaDestinacija = Destinacija(name: "Mi smo ovde", location: CLLocationCoordinate2DMake(44.8114168,20.4581917), zoom: 14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokreniSvojuPoziciju()
        
        
        
        GMSServices.provideAPIKey("AIzaSyDzMt04wvHs7D3ltO0viG9uyBu_MApQ43Q")
        let camera = GMSCameraPosition.cameraWithLatitude(mojaPozlat, longitude: mojaPozlong, zoom: 12)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView!.myLocationEnabled = true
        
        view = mapView
        self.mapView!.mapType = kGMSTypeTerrain
        
        
        
        let currentLocation = CLLocationCoordinate2DMake(mojaPozlat, mojaPozlong)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Vi ste ovde"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pronadjite nas", style: .Plain, target: self, action: "nadji")
        self.navigationItem.title = "Lomina 6, 11000 Beograd";
        
    }
    
    func nadji() {
        
        currentDestination = krajnjaDestinacija
        
        setMapCamera()
    }
    
    
//    
//    func nadji() {
//        
//        if currentDestination == nil {
//            currentDestination = krajnjaDestinacija.first
//        } else {
//            if let index = krajnjaDestinacija.indexOf(currentDestination!) where index < krajnjaDestinacija.count - 1 {
//                currentDestination = krajnjaDestinacija[index + 1]
//            }
//        }
//        
//        setMapCamera()
//    }

    
    
    private func setMapCamera() {
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(currentDestination!.location, zoom: currentDestination!.zoom))
        CATransaction.commit()
        
        let marker = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
    }

}
