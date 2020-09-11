//
//  WeatherViewVC.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewVC: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var lblLocation:UILabel!
    @IBOutlet weak var lblregion:UILabel!
    @IBOutlet weak var lblCountry:UILabel!
    @IBOutlet weak var lblTimeZone:UILabel!
    
    @IBOutlet weak var imgWeatherType:UIImageView!
    @IBOutlet weak var lblTemperature:UILabel!
    @IBOutlet weak var lblFelling:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var lblHumidity:UILabel!
    @IBOutlet weak var lblPrecipitation:UILabel!
    @IBOutlet weak var lblPressure:UILabel!
    @IBOutlet weak var lblWindSpeed:UILabel!
    @IBOutlet weak var lblWindDirection:UILabel!
    @IBOutlet weak var lblCloudCover:UILabel!
    @IBOutlet weak var lblVisibility:UILabel!
    @IBOutlet weak var lbluVindex:UILabel!
    @IBOutlet weak var lblupdatedAt:UILabel!
    
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    
    fileprivate var spWeatherModel = SPWeatherModel()
    fileprivate var currentWeather:Current!
    fileprivate var currentLocation:Location!
    
    public var selectedCordinates:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initializeWeatherVC()
    }
}
extension WeatherViewVC{
    //Initial state of weather detail view: index = 0 by default for metric scale
    func initializeWeatherVC(){
        spWeatherModel.index = 0
        spWeatherModel.selLat = selectedCordinates.latitude.description
        spWeatherModel.selLong = selectedCordinates.longitude.description
        setWeatherView()
    }
    
    func setWeatherView(){
        spWeatherModel.getWeatherList { (currentWeather, currentLocation,response)  in
            if response ==  ModelResponse.success{
                self.currentWeather = currentWeather
                self.currentLocation = currentLocation
                DispatchQueue.main.async{
                   if self.segmentedControl.selectedSegmentIndex == 0 {
                        self.lblTemperature.text = currentWeather.temperature.description +
                        " ºC"
                        self.lblFelling.text = currentWeather.feelslike.description + " ºC"
                        self.lblDescription.text = currentWeather.weatherDescriptions.first?.description
                        self.lblHumidity.text = currentWeather.humidity.description + " %"
                        self.lblPrecipitation.text = currentWeather.precip.description + " mm"
                        self.lblPressure.text = currentWeather.pressure.description + " MB"
                        self.lblWindSpeed.text = currentWeather.windSpeed.description + " km/hr"
                        self.lblWindDirection.text = currentWeather.windDir.description
                        self.lblCloudCover.text = currentWeather.cloudcover.description
                        self.lblVisibility.text = currentWeather.visibility.description
                        self.lbluVindex.text = currentWeather.uvIndex.description
                    }else{
                        self.lblTemperature.text = currentWeather.temperature.description +
                        " ºF"
                        self.lblFelling.text = currentWeather.feelslike.description + " ºF"
                        self.lblDescription.text = currentWeather.weatherDescriptions.first?.description
                        self.lblHumidity.text = currentWeather.humidity.description + " %"
                        self.lblPrecipitation.text = currentWeather.precip.description + " in"
                        self.lblPressure.text = currentWeather.pressure.description + " MB"
                        self.lblWindSpeed.text = currentWeather.windSpeed.description + " m/hr"
                        self.lblWindDirection.text = currentWeather.windDir.description
                        self.lblCloudCover.text = currentWeather.cloudcover.description
                        self.lblVisibility.text = currentWeather.visibility.description
                        self.lbluVindex.text = currentWeather.uvIndex.description
                    }
                    self.lblLocation.text = currentLocation.name.description

                    self.lblregion.text = currentLocation.region.description

                    self.lblCountry.text = currentLocation.country.description

                    self.lblupdatedAt.text = currentWeather.observationTime.description
                    self.lblTimeZone.text = currentLocation.timezoneID.description
                    
                    self.imgWeatherType.downloadImage(from: currentWeather.weatherIcons[0].description)
                }
                
            }
        }
    }
}

extension WeatherViewVC{
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
       
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            spWeatherModel.index = 0
            spWeatherModel.selLat = selectedCordinates.latitude.description
            spWeatherModel.selLong = selectedCordinates.longitude.description
            self.setWeatherView()
        case 1:
            
            spWeatherModel.index = 1
            spWeatherModel.selLat = selectedCordinates.latitude.description
            spWeatherModel.selLong = selectedCordinates.longitude.description
            self.setWeatherView()
        default:
            break
        }
    }
}
