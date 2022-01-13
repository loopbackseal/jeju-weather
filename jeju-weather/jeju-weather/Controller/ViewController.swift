//
//  ViewController.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        let cityName = "jeju"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let weather = WeatherManager()
        weather.fetchWeather(cityName: cityName)
    }


}

