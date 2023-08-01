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

## Screenshots

![SunnySeaAshShatibi](https://github.com/GarbuJohnG/MyWeatherApp/assets/60701720/60313f43-3d1d-4155-9120-6a82badfedf3)
![SunnyForestAshShatibi](https://github.com/GarbuJohnG/MyWeatherApp/assets/60701720/770d5945-f159-480a-9ae6-7443c966ef25)
![CloudySeaCupertino](https://github.com/GarbuJohnG/MyWeatherApp/assets/60701720/5e0e8869-2728-4215-a906-0da7132b2189)
![CloudyForestCupertino](https://github.com/GarbuJohnG/MyWeatherApp/assets/60701720/24fe036a-5364-41fa-ba3c-a65bf59e7b6d)
