//
//  ForecastCellVM.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation

struct ForecastCellModel {
    let dayOfWeek: String?
    let icon: String?
    let temp: Double?
}

class ForecastCellVM {
    
    private var dataModel: ForecastCellModel!
    
    // Output
    @Published private(set) var dayOfWeek: String?
    @Published private(set) var icon: String?
    @Published private(set) var temp: Double?
    
    init(dataModel: ForecastCellModel) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        dayOfWeek = dataModel.dayOfWeek
        icon = dataModel.icon
        temp = dataModel.temp
    }
    
}
