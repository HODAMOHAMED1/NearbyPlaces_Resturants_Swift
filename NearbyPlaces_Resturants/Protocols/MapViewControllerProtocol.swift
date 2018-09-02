//
//  MapViewControllerProtocol.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
protocol MapViewControllerPro {
    func acessLocation()
    func setMarker(location:[locationData])
    func showNoLocation()
}
