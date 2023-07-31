//
//  HomeVC.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import UIKit
import Combine

class HomeVC: UIViewController {

    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = HomeVM()
    
    // Check if refresh is still in progress
    var isRefreshInProgress = false
    
    private var loadListDataSubject = PassthroughSubject<Void,Never>()
    private var loadWeatherDataSubject = PassthroughSubject<Void,Never>()
    
    var scrollView = UIScrollView().manualLayoutable()
    var stkContents = UIStackView().manualLayoutable()
    var currentWeatherView = UIView().manualLayoutable()
    var currentWeatherImgView = UIImageView().manualLayoutable()
    var tableView = UITableView().manualLayoutable()
    var btnSettings = UIButton().manualLayoutable()
    
    var lblCurrentTemp = UILabel().manualLayoutable()
    var lblCurrentWeather = UILabel().manualLayoutable()
    var currentTempsView = CurrentTempsView().manualLayoutable()
    
    var separatorView = UIView().manualLayoutable()
    
    var tableHeight: NSLayoutConstraint!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureUI()
        
        ActivityIndicator.shared.showActivity(onView: view)
        loadListDataSubject.send()
        loadWeatherDataSubject.send()
    }
    
    // MARK: - Visual Setup
    
    private func configureUI() {
        setViewBGColor()
        setUpProperties()
        setupHierarchy()
        setUpAutoLayout()
    }
    
    private func setUpProperties() {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        scrollView.apply {
            $0.showsVerticalScrollIndicator = false
            $0.bounces = false
            $0.backgroundColor = .clear
        }
        
        stkContents.apply {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 0
            $0.backgroundColor = .clear
        }
        
        currentWeatherView.apply {
            $0.backgroundColor = AllMethods.get_weather_color(name: "")
        }
        
        currentWeatherImgView.apply {
            $0.contentMode = .scaleToFill
            $0.image = AllMethods.get_weather_image(name: "")
        }
        
        lblCurrentTemp.apply {
            $0.text = "0.00°"
            $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        lblCurrentWeather.apply {
            $0.text = "N/A"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        currentTempsView.setValues(min: 0.0, current: 0.0, max: 0.0)
        
        separatorView.apply {
            $0.backgroundColor = .white
        }
        
        tableView.apply {
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .clear
            
            ForecastCell.registerWithTable($0)
            $0.showsVerticalScrollIndicator = false
            $0.separatorStyle = .none
            $0.rowHeight = 40
        }
        
        btnSettings.apply {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
            
            $0.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        }
        
    }
    
    private func setupHierarchy() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stkContents)
        
        stkContents.addArrangedSubview(currentWeatherView)
        stkContents.addArrangedSubview(tableView)
        
        currentWeatherView.addSubview(currentWeatherImgView)
        currentWeatherView.addSubview(lblCurrentTemp)
        currentWeatherView.addSubview(lblCurrentWeather)
        currentWeatherView.addSubview(currentTempsView)
        currentWeatherView.addSubview(separatorView)
        currentWeatherView.addSubview(btnSettings)
    }
    
    private func setUpAutoLayout() {
        
        scrollView.apply {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).activate()
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).activate()
            $0.topAnchor.constraint(equalTo: view.topAnchor).activate()
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).activate()
        }
        
        stkContents.apply {
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).activate()
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).activate()
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).activate()
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -AllMethods.getTopSafeAreaConst()).activate()
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).activate()
        }
        
        currentWeatherView.apply {
            $0.heightAnchor.constraint(equalToConstant: view.bounds.width * 1.1).activate()
            $0.widthAnchor.constraint(equalToConstant: view.bounds.width).activate()
        }
        
        lblCurrentTemp.apply {
            $0.centerXAnchor.constraint(equalTo: currentWeatherView.centerXAnchor).activate()
            $0.centerYAnchor.constraint(equalTo: currentWeatherView.centerYAnchor, constant: -50).activate()
        }
        
        lblCurrentWeather.apply {
            $0.topAnchor.constraint(equalTo: lblCurrentTemp.bottomAnchor, constant: 10).activate()
            $0.centerXAnchor.constraint(equalTo: currentWeatherView.centerXAnchor).activate()
        }
        
        currentTempsView.apply {
            $0.heightAnchor.constraint(equalToConstant: 50).activate()
            $0.widthAnchor.constraint(equalToConstant: view.bounds.width).activate()
            $0.centerXAnchor.constraint(equalTo: currentWeatherView.centerXAnchor).activate()
            $0.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -5).activate()
        }
        
        currentWeatherImgView.apply {
            $0.topAnchor.constraint(equalTo: currentWeatherView.topAnchor).activate()
            $0.leadingAnchor.constraint(equalTo: currentWeatherView.leadingAnchor).activate()
            $0.trailingAnchor.constraint(equalTo: currentWeatherView.trailingAnchor).activate()
            $0.bottomAnchor.constraint(equalTo: currentTempsView.topAnchor, constant: -5).activate()
        }
        
        separatorView.apply {
            $0.heightAnchor.constraint(equalToConstant: 2).activate()
            $0.bottomAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: -20).activate()
            $0.leadingAnchor.constraint(equalTo: currentWeatherView.leadingAnchor).activate()
            $0.trailingAnchor.constraint(equalTo: currentWeatherView.trailingAnchor).activate()
        }
        
        tableView.apply {
            $0.widthAnchor.constraint(equalToConstant: view.bounds.width).activate()
            tableHeight = $0.heightAnchor.constraint(equalToConstant: 0).activate()
        }
        
        btnSettings.apply {
            $0.topAnchor.constraint(equalTo: currentWeatherView.topAnchor, constant: AllMethods.getTopSafeAreaConst()).activate()
            $0.trailingAnchor.constraint(equalTo: currentWeatherView.trailingAnchor, constant: -10).activate()
            $0.heightAnchor.constraint(equalToConstant: 40).activate()
            $0.widthAnchor.constraint(equalToConstant: 40).activate()
        }
        
    }
    
    private func setupBindings() {
        
        viewModel.attachListViewEventListener(loadData: loadListDataSubject.eraseToAnyPublisher())
        viewModel.attachWeatherViewEventListener(loadData: loadWeatherDataSubject.eraseToAnyPublisher())
        
        viewModel.reloadForecastList
            .sink(receiveCompletion: { completion in
            // Handle the error
            ActivityIndicator.shared.hideActivity()
        }) { [weak self] _ in
            ActivityIndicator.shared.hideActivity()
            self?.tableView.reloadData()
            self?.tableHeight.constant = CGFloat((self?.viewModel.numberOfRows ?? 0) * 40)
            self?.isRefreshInProgress = false
        }
        .store(in: &subscriptions)
        
        viewModel.reloadWeather
            .sink(receiveCompletion: { completion in
            // Handle the error
            ActivityIndicator.shared.hideActivity()
        }) { [weak self] _ in
            ActivityIndicator.shared.hideActivity()
            self?.updateCurrentWeather(self?.viewModel.weatherSource)
        }
        .store(in: &subscriptions)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(_:)), name: Notification.Name(LOC_FOUND), object: nil)
        
    }
    
    // MARK: - Handlers
    
    // Observe notification events from LocationManager.
    @objc private func locationAvailable(_ notification: Notification) {
        guard !isRefreshInProgress else { return }
        refreshScreen()
    }
    
    @objc private func openSettings() {
        let vc = SettingsVC()
        vc.colorString = viewModel.weatherSource?.weather?.first?.main ?? ""
        vc.themeChanged = { [self] in
            updateCurrentWeather(viewModel.weatherSource)
        }
        vc.unitsChanged = { [self] in
            updateCurrentWeather(viewModel.weatherSource)
            tableView.reloadData()
        }
        present(vc, animated: true)
    }
    
    // Refresh the page
    private func refreshScreen() {
        setupBindings()
        isRefreshInProgress = true
        loadListDataSubject.send()
        loadWeatherDataSubject.send()
    }
    
    // Update Weather Items
    
    func updateCurrentWeather(_ weather: WeatherResponse?) {
        if let weather = weather {
            
            let units = UserDefaults.standard.string(forKey: UNITS_SETTING) ?? "Metric"
            
            var tempInDegrees = 0.0
            if units == "Metric" {
                tempInDegrees = (weather.main?.temp ?? 0.00) + KELVIN_CONST
            } else {
                tempInDegrees = (1.8 * ((weather.main?.temp ?? 0.00) + KELVIN_CONST)) + 32
            }
            
            lblCurrentTemp.text = String(format:"%.2f° \(units == "Metric" ? "C" : "F")",tempInDegrees)
            lblCurrentWeather.text = "\(weather.weather?.first?.main ?? "") in \(weather.name ?? "")"
            
            currentTempsView.setValues(min: weather.main?.tempMin ?? 0.0, current: weather.main?.temp ?? 0.0, max: weather.main?.tempMax ?? 0.0)
            
            currentWeatherView.backgroundColor = AllMethods.get_weather_color(name: weather.weather?.first?.main ?? "")
            currentWeatherImgView.image = AllMethods.get_weather_image(name: weather.weather?.first?.main ?? "")
            view.backgroundColor = AllMethods.get_weather_color(name: weather.weather?.first?.main ?? "")
            
        } else {
            
            lblCurrentTemp.text = "0.00"
            lblCurrentWeather.text = "N/A"
            
            currentTempsView.setValues(min: 0.0, current: 0.0, max: 0.0)
            
            currentWeatherView.backgroundColor = AllMethods.get_weather_color(name: "")
            currentWeatherImgView.image = AllMethods.get_weather_image(name: "")
            view.backgroundColor = AllMethods.get_weather_color(name: "")
            
        }
    }
    
    // MARK: - Server Calls

}

// MARK: UITableView Datasource & Delegate

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as! ForecastCell
        cell.selectionStyle = .none
        cell.prepareCell(viewModel:  viewModel.tableDataSource[indexPath.row])
        return cell
    }
}
