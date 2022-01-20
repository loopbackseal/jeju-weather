//
//  ViewController.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import UIKit

class ViewController: UIViewController, WeatherManagerDelegate {
    func updateUI(_ weatherManager: WeatherManager, model: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel1.text = "기온: \(model.temp)℃  습도: \(model.humidity)%"
            self.tempLabel2.text = "풍속: \(model.wind)m/s 구름: \(model.cloud)%"
            self.conditionLabel.text = "\(model.condition)🍊"
            self.weatherImageView.image = UIImage(systemName: model.conditionImage)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel1: UILabel!
    @IBOutlet weak var tempLabel2: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private var phoneNumber: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "PHONE_NUMBER") as? String else {
          fatalError("Couldn't find key 'PHONE_NUMBER' in 'Info.plist'.")
        }
        return value
      }
    }
    
    var weather = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.delegate = self
        weather.fetchWeather(cityName: "jeju")
    }

    @IBAction func refreshButtonTouched(_ sender: UIButton) {
        weather.delegate = self
        weather.fetchWeather(cityName: "jeju")
    }
    
    
    @IBAction func phoneCallButtonTouched(_ sender: UIButton) {
        dialNumber(number: phoneNumber)
    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                print("error occurs in dial")
       }
    }
}

