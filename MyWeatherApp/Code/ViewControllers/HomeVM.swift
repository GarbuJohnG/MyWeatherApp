//
//  HomeVM.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import Combine

class HomeVM {
    
    private var subscriptions = Set<AnyCancellable>()
    
    // Data source for the home page table view.
    
    var tableDataSource: [ForecastCellVM] = [ForecastCellVM]()
    var weatherSource: WeatherResponse?
    
    private var forecastList = [List]()
    
    // MARK: Input
    
    private var loadData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private var loadWeatherData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    
    // MARK: Output
    
    var numberOfRows: Int {
        tableDataSource.count
    }
    
    var reloadForecastList: AnyPublisher<Result<Void, APIError>, Never> {
        reloadForecastListSubject.eraseToAnyPublisher()
    }
    
    var reloadWeather: AnyPublisher<Result<Void, APIError>, Never> {
        reloadWeatherSubject.eraseToAnyPublisher()
    }
    
    private let reloadForecastListSubject = PassthroughSubject<Result<Void, APIError>, Never>()
    private let reloadWeatherSubject = PassthroughSubject<Result<Void, APIError>, Never>()
    
    // MARK: Init
    
    init() { }
    
    // Attatch Forecast Event Lstener
    
    func attachListViewEventListener(loadData: AnyPublisher<Void, Never>) {
        self.loadData = loadData
        self.loadData
            .setFailureType(to: APIError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.forecastList.removeAll()
            })
            .flatMap { _ -> AnyPublisher<[List], APIError> in
                let networkService = NetworkService()
                return networkService
                    .fetch5DayForecast()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.tableDataSource.removeAll()
            })
            .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] list in
                self?.forecastList.append(contentsOf: list)
                self?.prepareTableDataSource()
                self?.reloadForecastListSubject.send(.success(()))
            })
            .store(in: &subscriptions)
    }
    
    // Attatch Current Weather Event Lstener
    
    func attachWeatherViewEventListener(loadData: AnyPublisher<Void, Never>) {
        self.loadWeatherData = loadData
        self.loadWeatherData
            .setFailureType(to: APIError.self)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.weatherSource = nil
            })
            .flatMap { _ -> AnyPublisher<WeatherResponse, APIError> in
                let networkService = NetworkService()
                return networkService
                    .fetchWeather()
            }
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.weatherSource = nil
            })
            .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] resp in
                self?.weatherSource = resp
                self?.reloadWeatherSubject.send(.success(()))
            })
            .store(in: &subscriptions)
    }
    
    // Prepare TableDataSource
    
    private func prepareTableDataSource() {
        tableDataSource.append(contentsOf: forecastCells())
    }
    
    private func forecastCells() -> [ForecastCellVM] {
        var cells: [ForecastCellVM] = [ForecastCellVM]()
        for each in forecastList {
            let dataModel = ForecastCellModel(dayOfWeek: each.dtTxt, icon: each.weather?.first?.main, temp: each.main?.temp)
            let cell = ForecastCellVM(dataModel: dataModel)
            cells.append(cell)
        }
        return cells
    }
    
    
}
