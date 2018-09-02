//
//  ViewController.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class ViewController: UIViewController,ViewControllerPro,CLLocationManagerDelegate{
    
    
    
    @IBOutlet weak var map: GMSMapView!
    var presenter:PresenterPro!
    var deviceid:String!
    var locationManager = CLLocationManager()
    var userLocation:CLLocation!
    var allArray:[locationData]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        acessLocation()
        deviceid="1234567890"
        print(deviceid)
        presenter=Presenter(view: self)
        presenter.authLogin(deviceid: deviceid)
    }
    
    @IBAction func showmap() {
        performSegue(withIdentifier: "segue", sender: self)
    }
    // method receive jwt and request data
    func setJwt(jwt: String) {
        print("back"+jwt)
        presenter.getPlaces(jwt:jwt, latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
    }
    
    func acessLocation()
    {
        //when we request access to the location even when the App is closed
        locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled())
        {
            print("acess")
            locationManager.delegate = self
            locationManager.desiredAccuracy=kCLLocationAccuracyBest // location accuracy
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("hire:\(location.coordinate)")
            userLocation=locations.last
            //foucs on user location
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                                  longitude: userLocation!.coordinate.longitude, zoom: 11)
            self.map.camera = camera
            self.map.animate(to:camera)
            locationManager.stopUpdatingLocation() // we use it if we want to stop any update in location
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied)
        {
            // if the location access became disable
            showNoLocation()
        }
    }
    // method to tell user that location access became disable
    func showNoLocation()
    {
        let alert = UIAlertController(title: "Location Acess Disabled ", message: "we need your location", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.default, handler:nil))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
    }
    
    func setMarker(location: [locationData]) {
        for i in 0...location.count-1
        {
            // loop on array and set marker at each resturant location
            allArray = location
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(location[i].long!,location[i].lat!)
            print ("position\(marker.position)")
            marker.title = location[i].en
            marker.map = map
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var mapController = segue.destination as! MapViewController
        // send array to mapController
        mapController.array=allArray
        
    }
}
