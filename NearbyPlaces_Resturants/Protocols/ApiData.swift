//
//  ApiData.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
protocol ApiPro {
    func authLogin(deviceid:String)
    func getPlaces(jwt:String,latitude:Double,longitude:Double)
}
