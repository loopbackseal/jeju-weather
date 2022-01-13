//
//  WeatherManager.swift
//  jeju-weather
//
//  Created by Young Soo Hwang on 2022/01/13.
//

import Foundation
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

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apiKey)&units=metric&lang=kr"
    
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
    
    
    func handle(data: Data?, response: URLResponse?, error: Error?)  {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            // if use this method by closure,
            // self.parseJSON(weatherData: safeData)
            parseJSON(weatherData: safeData)
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self , from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].description
            print(temp, id)
        } catch {
            print(error)
        }
    }
    
    func getConditionName(code : Int) {
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
            
        }
    }
}
