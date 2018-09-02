//
//  Model.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class Model: NSObject,ModelPro{
    var api:ApiPro!
    var presenter:PresenterPro!
    init(present:PresenterPro)
    {
        super.init()
        presenter=present
        self.initmodel()
    }
    func initmodel()
    {
        api=ApiData(mod: self)
    }
    func authLogin(deviceid: String){
        api.authLogin(deviceid: deviceid)
    }
    func setJwt(jwt: String) {
        presenter.setJwt(jwt: jwt)
    }
    func getPlaces(jwt: String, latitude: Double, longitude: Double) {
        api.getPlaces(jwt: jwt, latitude: latitude, longitude: longitude)
    }
    func setMarker(location: [locationData]) {
        presenter.setMarker(location: location)
    }
    
    
}
