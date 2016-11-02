//
//  ViewController.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 01/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC : UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!

    var locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    var currentWeather : CurrentWeather!
//    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
       super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        forecast = Forecast()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
        
    }
    
    func locationAuthStatus(){
    
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location!
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather = CurrentWeather()
            currentWeather.downloadWeatherDetails {
                self.downloadForeCastData {
                    self.updateMainUI()
                }
                
            }

            
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }

    func downloadForeCastData(completed : @escaping DownloadComplete){
    
        let forecastURL = URL(string: FORECAST_URL)
        Alamofire.request(forecastURL!).responseJSON{ response in
        
            let result = response.result
            
            if let dict  = result.value as? Dictionary<String,AnyObject>{
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list {
                        let fc = Forecast(weatherDict : obj)
                        self.forecasts.append(fc)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            
            completed()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        
        return WeatherCell()
    
    }
    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        placeLabel.text = currentWeather.cityName
        currentWeatherLabel.text = "\(currentWeather.currentTemp) ℃"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
        print("test \(currentWeather.date) \(currentWeather.cityName) \(currentWeather.currentTemp)")

        
    }


}

