//
//  WeatherDetailModel.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation
struct SPWeatherModel{
    
    var currentWeather:Current
    var currentLocation:Location
    var selLat:String = ""
    var selLong:String = ""
    var index:Int = 0
    
    
    init(currentWeather:Current,currentLocation:Location) {
        self.currentWeather = currentWeather
        self.currentLocation = currentLocation
    }
    
    init() {
        self.currentWeather  = Current.init(observationTime: "", temperature: 0, weatherCode: 0, weatherIcons: [], weatherDescriptions: [], windSpeed: 0, windDegree: 0, windDir: "", pressure: 0, precip: 0.0, humidity: 0, cloudcover: 0, feelslike: 0, uvIndex: 0, visibility: 0, isDay: "")
        self.currentLocation = Location.init(name: "", country: "", region: "", lat: "", lon: "", timezoneID: "", localtime: "", localtimeEpoch: 0, utcOffset: "")
    }
    
    func getWeatherList(callback : @escaping((_ weather : Current , _ locationDetail: Location, _ message : ModelResponse?) -> Void))
    {
        let reqLat = selLat
        let reqLong = selLong
        
        RestWebServices.sharedInstance.getCurrentWeatherData(fromURL: RestServices.baseUrl, withHttpMethod: .get, requestType: RestServices.currentReq, deviceLat: reqLat, deviceLong: reqLong, deviceToken: RestServices.apiToken,units:index == 0 ? tempUnits.m.rawValue : tempUnits.f.rawValue,onSuccess: { (currentWeatherData) in
            print(currentWeatherData.current)
            callback(currentWeatherData.current,currentWeatherData.location, .success)
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}
