//
//  ViewCoontrollerPotocol.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
protocol ViewControllerPro {
    func acessLocation()
    func setJwt(jwt:String)
    func setMarker(location:[locationData])
    func showNoLocation()
}
