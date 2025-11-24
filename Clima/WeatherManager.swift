//
//  WeatherManager.swift
//  Clima
//
//  Created by Immanuel Yohansen on 21/11/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=7036c2f7da607f73b8adf77dda29e77e&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            //create session
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData)
            let id = decodedData.weather[0].id
            print(getConditionName(weatherId: id))
        } catch {
            print(error)
        }
     }
    
    func getConditionName(weatherId: Int)-> String {
        switch weatherId {
        case 200 ... 232 :
            return "Thunderstorm"
        case 300 ... 321 :
            return "Drizzle"
        case 500 ... 531 :
            return "Rain"
        case 600 ... 622 :
            return "Snow"
        case 701 ... 781 :
            return "Atmosphere"
        case 800 :
            return "Clear"
        case 801 ... 804 :
            return "Clouds"
        default:
            return "Unknown"
        }
    }
}
