//
//  WeatherManager.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateUI(_ weatherManager: WeatherManager, model: WeatherModel)
    func didFailWithError(error: Error)
}

// Use Plist for get API_KEY
private var apiKey: String {
  get {
    // 1
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }
    return value
  }
}

var weatherInfo: [String] = ["0", "0", "heart.fill", "맑음", "0", "0"]

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric&lang=kr"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. Create a URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            // if you use closure
            /*
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
             }
            */
            
            // 4. Start the task
            task.resume()
        }
    }
    
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            delegate?.didFailWithError(error: error!)
            return
        }
        
        if let safeData = data {
            // if use this method by closure,
            // self.parseJSON(weatherData: safeData)
            if let weather = parseJSON(weatherData: safeData) {
                delegate?.updateUI(self, model: weather)
            }
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self , from: weatherData)
            let temp = String(format: "%.0f", round(decodedData.main.temp))
            let humidity = String(decodedData.main.humidity)
            let id = decodedData.weather[0].id
            let condition = decodedData.weather[0].description
            let wind = String(decodedData.wind.speed)
            let cloud = String(decodedData.clouds.all)
            let weather = WeatherModel(temp: temp, humidity: humidity, conditionImage: getConditionImg(code: id), condition: condition, wind: wind, cloud: cloud)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getConditionImg(code : Int) -> String {
        switch code
        {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "wind.snow"
        case 700...781:
            return "sun.haze.fill:"
        case 800:
            return "sun.max.fill"
        case 801...802:
            return "cloud.sun.fill"
        case 803...804:
            return "smoke.fill"
        default:
            return "Untitled design (1)"
        }
    }
}
