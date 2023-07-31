//
//  NetworkService.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import Combine

struct NetworkService {
    
    // Fetch current weather details
    
    func fetchWeather() -> AnyPublisher<WeatherResponse, APIError> {
        
        let userLat = LocationManager.shared.latitude
        let userLong = LocationManager.shared.longitude
        
        if userLat == 0.0 && userLong == 0.0 {
            return Fail(error: APIError.locationError).eraseToAnyPublisher()
        }

        let url = NetworkConstants.baseURL + NetworkConstants.weatherAPI + "?lat=\(userLat)&lon=\(userLong)&appid=\(openWeatherApiKey)"

        let placeResponsePublisher: AnyPublisher<WeatherResponse, APIError> = NetworkManager.shared.requestAPI(url: url)
    
        return placeResponsePublisher.print("\n fetch weather").eraseToAnyPublisher()
        
    }
    
    // Fetch weather forecast for the next n days
    
    func fetch5DayForecast() -> AnyPublisher<[List], APIError> {
        
        let userLat = LocationManager.shared.latitude
        let userLong = LocationManager.shared.longitude
        
        if userLat == 0.0 && userLong == 0.0 {
            return Fail(error: APIError.locationError).eraseToAnyPublisher()
        }

        let url = NetworkConstants.baseURL + NetworkConstants.forecastAPI + "?lat=\(userLat)&lon=\(userLong)&appid=\(openWeatherApiKey)"

        let placeResponsePublisher: AnyPublisher<ForecastResponse, APIError> = NetworkManager.shared.requestAPI(url: url)
    
        return placeResponsePublisher.print("\n fetch forecast list")
            .map { $0.list ?? [] }
            .eraseToAnyPublisher()
        
    }
}
