//
//  ViewController.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel1: UILabel!
    @IBOutlet weak var tempLabel2: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var phoneCallButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let weather = WeatherManager()
        weather.fetchWeather(cityName: "jeju")
    }


}

