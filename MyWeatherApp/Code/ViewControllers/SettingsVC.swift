//
//  SettingsVC.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 31/07/2023.
//

import UIKit
import Combine

class SettingsVC: UIViewController {
    
    // MARK: - Properties
    
    var colorString: String?
    
    var themeChanged: (() -> ())?
    var unitsChanged: (() -> ())?
    
    var btnClose = UIButton().manualLayoutable()
    var lblTitle = UILabel().manualLayoutable()
    var lblTheme = UILabel().manualLayoutable()
    var themeSC = UISegmentedControl().manualLayoutable()
    var lblUnits = UILabel().manualLayoutable()
    var unitsSC = UISegmentedControl().manualLayoutable()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Visual Setup
    
    private func configureUI() {
        setViewBGColor(color: AllMethods.get_weather_color(name: colorString ?? ""))
        setUpProperties()
        setupHierarchy()
        setUpAutoLayout()
    }
    
    private func setUpProperties() {
        
        btnClose.apply {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            
            $0.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)
        }
        
        lblTitle.apply {
            $0.text = "Settings"
            $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
            $0.textColor = .white
        }
        
        lblTheme.apply {
            $0.text = "Designs/Themes"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .white
        }
        
        let selectedTheme = UserDefaults.standard.string(forKey: THEME_SETTING) ?? "Forest"
        
        themeSC = UISegmentedControl(items: ["Forest","Sea"]).manualLayoutable()
        themeSC.apply {
            
            $0.selectedSegmentIndex = selectedTheme == "Forest" ? 0 : 1
            
            $0.addTarget(self, action: #selector(themeValueChanged(_:)), for: .valueChanged)
        }
        
        lblUnits.apply {
            $0.text = "Units"
            $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .white
        }
        
        let selectedUnits = UserDefaults.standard.string(forKey: UNITS_SETTING) ?? "Metric"
        
        unitsSC = UISegmentedControl(items: ["Metric","Imperial"]).manualLayoutable()
        unitsSC.apply {
            
            $0.selectedSegmentIndex = selectedUnits == "Metric" ? 0 : 1
            
            $0.addTarget(self, action: #selector(unitsValueChanged(_:)), for: .valueChanged)
        }
        
        
    }
    
    private func setupHierarchy() {
        
        view.addSubview(btnClose)
        view.addSubview(lblTitle)
        view.addSubview(lblTheme)
        view.addSubview(themeSC)
        view.addSubview(lblUnits)
        view.addSubview(unitsSC)
        
    }
    
    private func setUpAutoLayout() {
        
        btnClose.apply {
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).activate()
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).activate()
            $0.heightAnchor.constraint(equalToConstant: 40).activate()
            $0.widthAnchor.constraint(equalToConstant: 40).activate()
        }
        
        lblTitle.apply {
            $0.topAnchor.constraint(equalTo: btnClose.bottomAnchor, constant: 20).activate()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
        }
        
        lblTheme.apply {
            $0.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).activate()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
        }
        
        themeSC.apply {
            $0.topAnchor.constraint(equalTo: lblTheme.bottomAnchor, constant: 20).activate()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).activate()
        }
        
        lblUnits.apply {
            $0.topAnchor.constraint(equalTo: themeSC.bottomAnchor, constant: 20).activate()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
        }
        
        unitsSC.apply {
            $0.topAnchor.constraint(equalTo: lblUnits.bottomAnchor, constant: 20).activate()
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).activate()
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).activate()
        }
        
    }
    
    // MARK: - Handlers
    
    @objc func dismissPage() {
        self.dismiss(animated: true)
    }
    
    @objc func themeValueChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.titleForSegment(at: sender.selectedSegmentIndex), forKey: THEME_SETTING)
        setViewBGColor(color: AllMethods.get_weather_color(name: colorString ?? ""))
        themeChanged?()
    }
    
    @objc func unitsValueChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.titleForSegment(at: sender.selectedSegmentIndex), forKey: UNITS_SETTING)
        unitsChanged?()
    }
    
    // MARK: - Server Calls
    
}
