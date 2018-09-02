//
//  MapViewController.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/14/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SDWebImage

class MapViewController: UIViewController, CLLocationManagerDelegate,MapViewControllerPro,GMSMapViewDelegate{
    
    var locationManager = CLLocationManager()
    var userLocation:CLLocation!
    var presenter:PresenterPro!
    var array:[locationData]?
    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var details: UIView!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var telephoneNumber: UILabel!
    @IBOutlet weak var hotlineNumber: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        map.delegate=self
        acessLocation()
        cardview.image=UIImage(named:"card")
        self.cardview.addSubview(details)
        self.map.addSubview(cardview)
        cardview.isHidden=true
        self.setMarker(location: array!)
    }
    func acessLocation()
    {
        locationManager.requestAlwaysAuthorization()
        if(CLLocationManager.locationServicesEnabled())
        {
            print("acess")
            locationManager.delegate = self
            locationManager.desiredAccuracy=kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("hire:\(location.coordinate)")
            userLocation=locations.last
            let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                                  longitude: userLocation!.coordinate.longitude, zoom: 13)
            self.map.camera = camera
            self.map.animate(to:camera)
            locationManager.stopUpdatingLocation()
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied)
        {
            //location access became disable
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
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(location[i].long!,location[i].lat!)
            print ("position\(marker.position)")
            marker.title = location[i].en
            marker.userData=location[i]
            marker.map = map
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        cardview.isHidden=true
        cardview.isHidden=false
        let location = marker.userData as! locationData
        name.text=location.en
        telephoneNumber.text=location.telephoneNumber
        mobileNumber.text=location.mobileNumber
        hotlineNumber.text=location.hotLineNumber
        imageView.sd_setImage(with: URL(string:location.placeProfilePictureUrl!))
        print("location eng"+location.en!)
        return true
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
