//
//  Location.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
class locationData: NSObject
{
    var name:NSDictionary?
    var ar:String?
    var en:String?
    var lat:Double?
    var long:Double?
    var address:NSDictionary?
    var emailAddresses:NSArray?
    var openingTimes:NSDictionary?
    var location:NSDictionary?
    var placeProfilePictureUrl :String?
    var hotLineNumber :String?
    var mobileNumber :String?
    var telephoneNumber :String?
    
    init (json:JSON)
    {
        super.init()
        if let n = json["name"].dictionary
        {
            self.name = n as NSDictionary
            ar = n["ar"]?.string
            en = n["en"]?.string
            print(ar)
        }
        if let n = json["address"].dictionary
        {
            self.address = n as NSDictionary
        }
        if let n = json["emailAddresses"].array
        {
            self.emailAddresses = n as NSArray
        }
        if let n = json["openingTimes"].dictionary
        {
            self.openingTimes = n as NSDictionary
        }
        if let n = json["location"].dictionary
        {
            self.location = n as NSDictionary
            var coordinates = n["coordinates"]
            lat = coordinates?[0].double
            long = coordinates?[1].double
            print(lat)
        }
        if let n = json["placeProfilePictureUrl"].string
        {
            self.placeProfilePictureUrl = n as String
        }
        if let n = json["hotLineNumber"].string
        {
            self.hotLineNumber = n as String
        }
        if let n = json["hotLineNumber"].string
        {
            self.hotLineNumber = n as String
        }
        if let n = json["mobileNumber"].string
        {
            self.mobileNumber = n as String
        }
        if let n = json["telephoneNumber"].string
        {
            self.telephoneNumber = n as String
        }
    }
}

