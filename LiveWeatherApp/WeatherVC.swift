//
//  ViewController.swift
//  LiveWeatherApp
//
//  Created by Darshan Gowda on 01/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit

class WeatherVC : UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let we = CurrentWeather()
        we.downloadWeatherDetails {
            //
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        return cell
    
    }


}

