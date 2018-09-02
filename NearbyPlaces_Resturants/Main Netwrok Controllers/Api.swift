//
//  Api.swift
//  QurbaTask_NearbyPlaces
//
//  Created by Admin on 8/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiData: NSObject,ApiPro {
    
    var model:ModelPro!
    var dataobj:locationData!
    var all:NSMutableArray?
    
    init(mod:ModelPro) {
        model=mod
    }
    
    // connect with login authorization Api and get jwt
    func authLogin(deviceid: String){
        let parameter = [
            "payload": [
                "deviceId":deviceid
            ]
        ]
        Alamofire.request("https://backend-user-alb.qurba-dev.com/auth/login-guest/", method:.post, parameters: parameter, encoding:JSONEncoding.default, headers: nil).responseJSON{ response in
            guard response.result.error==nil else
            {
                print("error calling POST")
                print(response.result.error!)
                return
            }
            guard let jsonobj=response.result.value as? [String:Any] else{
                print("didn't get object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            let res = jsonobj["response"] as? NSDictionary
            let payload = res!["payload"] as? NSDictionary
            let jwt = payload!["jwt"] as? String
            self.model.setJwt(jwt: jwt!)
            print(jwt)
        }
    }
    
    // connect with data Api and get all places
    func getPlaces(jwt: String, latitude: Double, longitude: Double) {
        print("JWT "+jwt)
        let param = [
            "payload": [
                "lng":longitude,
                "lat":latitude
            ]
        ]
        let headers = ["Authorization": "JWT "+jwt,
                       "Content-Type": "application/json"]
        
        Alamofire.request("https://backend-user-alb.qurba-dev.com/places/places/nearby?page=1", method:.post, parameters: param, encoding: JSONEncoding.default, headers:headers).responseJSON { response in
            guard response.result.error==nil else
            {
                print("error calling POST")
                print(response.result.error!)
                return
            }
            guard let jsonobj=response.result.value as? [String:Any] else{
                print("didn't get object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            self.all = NSMutableArray()
            let json = JSON(jsonobj)
            let response = json["response"]
            let data = response["payload"]
            for i in 0...data.count-1
            {
                self.dataobj = locationData(json: data[i])
                self.all?.add(self.dataobj)
            }
            let array = self.all as?[locationData]
            self.model.setMarker(location: array!)
        }
    }
}
