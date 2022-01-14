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
    
    let weather = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weather.fetchWeather(cityName: "jeju")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.updateUI(weatherInfo)
        }
    }

    @IBAction func refreshButtonTouched(_ sender: UIButton) {
        weather.fetchWeather(cityName: "jeju")
        updateUI(weatherInfo)
    }
    
    func updateUI(_ weatherArray: [String]) {
        tempLabel1.text = "기온: \(weatherArray[0])℃  습도: \(weatherArray[1])%"
        tempLabel2.text = "풍속: \(weatherArray[4])m/s 구름: \(weatherArray[5])%"
        conditionLabel.text = "\(weatherArray[3])🍊"
        weatherImageView.image = UIImage(systemName: weatherArray[2])
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
                print("WTF")// add error message here
       }
    }
}

