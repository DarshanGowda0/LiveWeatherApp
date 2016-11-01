//
//  Constants.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 01/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import Foundation

let BASE_URL  = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE  = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "3db24a2b47bc4d805610b7bcd4959b6f"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGITUDE)123\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=-36&lon=123&cnt=10&mode=json&appid=3db24a2b47bc4d805610b7bcd4959b6f"

