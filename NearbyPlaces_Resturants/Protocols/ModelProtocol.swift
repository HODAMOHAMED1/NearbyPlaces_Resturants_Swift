//
//  ModelProtocol.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
protocol ModelPro{
    func authLogin(deviceid:String)
    func setJwt(jwt:String)
    func getPlaces(jwt:String,latitude:Double,longitude:Double)
    func setMarker(location:[locationData])
}
