//
//  Presenter.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class Presenter: NSObject,PresenterPro {
    
    var viewcont:ViewControllerPro!
    var model:ModelPro!
    init(view:ViewControllerPro){
        super.init()
        viewcont=view
        self.initpresenter()
    }
    
    func initpresenter()
    {
        model=Model(present: self)
    }
    
    func authLogin(deviceid: String){
        model.authLogin(deviceid: deviceid)
    }
    
    func setJwt(jwt: String) {
        viewcont.setJwt(jwt: jwt)
    }
    func getPlaces(jwt: String, latitude: Double, longitude: Double) {
        model.getPlaces(jwt: jwt, latitude: latitude, longitude: longitude)
    }
    func setMarker(location: [locationData]) {
        viewcont.setMarker(location: location)
    }
}
