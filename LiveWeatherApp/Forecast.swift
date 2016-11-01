//
//  Forecast.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 01/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation
import Alamofire

class Forecast{

    private var _date : String!
    private var _weatherType : String!
    private var _highTemp :String!
    private var _lowTemp : String!
    
    var date : String{
        if _date == nil{
            _date = ""
        }
        return _date!
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType!
    }

    var highTemp : String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp!
    }
    
    var lowTemp : String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp!
    }
    
    init(weatherDict : Dictionary<String,AnyObject>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject>{
            if let min = temp["min"] as?  Double{
                let kelvinToFarenheit = (min*(9/5)-459.67)
                let temp2 = Double(round(10*kelvinToFarenheit/10))
                self._lowTemp = "\(temp2)"
            }
            if let max = temp["max"] as?  Double{
                let kelvinToFarenheit = (max*(9/5)-459.67)
                let temp3 = Double(round(10*kelvinToFarenheit/10))
                self._highTemp = "\(temp3)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double{
            
            let unixDate  = Date(timeIntervalSince1970 : date)
            let dateFormatter  = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            self._date = unixDate.dayOfTheWeek()
            
        }
        
        
        
    }
}

extension Date{
    func dayOfTheWeek()->String{
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
        
    }
}

