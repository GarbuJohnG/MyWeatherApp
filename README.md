# MyWeatherApp

# Overview

MyWeatherApp has been developed as a fulfilment of a Mobile assessment showcasing knowledge in IOS Development.

The App provides the Weather of a user's current location alongside a 5 day 3 hourly forecast of the same location. It also has two themes Forest and Sea with weather changes of a location being visually represented via the images and icons provides.

## Run the App

Pull or download the project to your machine and run 'MyWeatherApp.xcodeproj' using XCode. Build and run the app on the preferred simulator or device (NOTE: You'll have to register the AppID with your Developer ID to run it on your Device).

## App Use

MyWeatherApp will ask for location permissions on launch. After the permissions are provided, two calls are made to [OpenWeather](https://openweathermap.org), one for current user's location weather and another for a 5 day 3 hourly forecast of the same location. These details are then presented to the user. Depending on the weather, the images, icons and color change to reflect the same.

On the Settings page, one can change between Forest and Sea themes. Additionally one can change the Units between Metric and Imperial. These settings are persisted using UserDefaults.

## Endpoints

- [OpenWeather](https://openweathermap.org)

## Persistence

- UserDefaults have been used to save the Theme and Units Settings

## Tech and Structures
- [x] URLSession
- [X] RESTful APIs
- [x] TableView
- [x] Combine
- [x] MVVM Pattern
- [x] UserDefaults



