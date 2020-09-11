//
//  Constants.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation
import UIKit

//User Defaults
let Defaults = UserDefaults.standard

//Screen Constanst
struct Screen{
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct RestServices{
    //URL Constants
    static let baseUrl:String = "http://api.weatherstack.com/"
    static let currentReq:String = "current?"
    static let apiToken:String = "4107bed54f6a9494a671c732b422566f"
}


//VC Name Constants
struct VC{
    static let kMapViewVC:String = "MapViewVC"
    static let kWeatherViewVC:String = "WeatherViewVC"
}

//Response Message Constants
struct ResponseMsg{
    static let KSuccess:String = "Success"
    static let kFail:String = "Fail"
}

//Service Response 
enum ModelResponse: String {
    case success
    case faliure
    
}
//units
enum tempUnits: String {
    case m
    case f
}



struct LocationConstants {
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let lastKnownLatitude = "lastKnownLatitude"
    static let lastKnownLongitude = "lastKnownLongitude"
}
