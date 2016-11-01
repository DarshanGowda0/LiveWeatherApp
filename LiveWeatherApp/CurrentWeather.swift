//
//  CurrentWeather.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 01/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather{
    
    private var _cityName: String!
    private var _date : String!
    private var _weatherType : String!
    private var _currentTemp : Double!
    
    var cityName : String {
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName!
    }
    
    var weatherType :String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType!
    }
    
    var currentTemp : Double{
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp!
    }
    
    var date : String {
        if _date == nil{
            _date = ""
        }
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        
        let currentDate = dateformatter.string(from: Date())
        self._date = "Today \(currentDate)"
        
        return _date!
    }
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete){
        
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        print(CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherUrl).responseJSON{ response in
            let result  = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = main["temp"] as? Double{
                        let kelvinToFarenheit = (temp*(9/5)-459.67)
                        let temp2 = Double(round(10*kelvinToFarenheit/10))
                        self._currentTemp = temp2
                    }
                }
                
                print("\(self._cityName!) \(self._weatherType!) \(self._currentTemp!)")
                
            }
            completed()
        }
    }
    
}
