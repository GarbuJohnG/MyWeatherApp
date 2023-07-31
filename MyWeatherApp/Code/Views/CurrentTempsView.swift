//
//  CurrentTempsView.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 31/07/2023.
//

import UIKit

class CurrentTempsView: UIView {
    
    // MARK: - Properties
    var lblMinTemp = UILabel().manualLayoutable()
    var lblCurrentTemp = UILabel().manualLayoutable()
    var lblMaxTemp = UILabel().manualLayoutable()
    
    var lblMinTempTitle = UILabel().manualLayoutable()
    var lblCurrentTempTitle = UILabel().manualLayoutable()
    var lblMaxTempTitle = UILabel().manualLayoutable()
    
    var stkTemps = UIStackView().manualLayoutable()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Visual Setup
    func setup() {
        
        addSubview(stkTemps)
        
        let titleLabelArr = [lblMinTempTitle,lblCurrentTempTitle,lblMaxTempTitle]
        let labelArr = [lblMinTemp,lblCurrentTemp,lblMaxTemp]
        
        for each in titleLabelArr {
            each.apply {
                $0.font = UIFont.systemFont(ofSize: 12, weight: .light)
                $0.textAlignment = .left
                $0.textColor = .white
            }
        }
        
        for each in labelArr {
            each.apply {
                $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                $0.textAlignment = .left
                $0.textColor = .white
            }
        }
        
        stkTemps.apply {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .fill
            $0.spacing = 0
            
            
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 5).activate()
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).activate()
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).activate()
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).activate()
        }
        
        for i in (0..<3) {
            
            let view = UIView().manualLayoutable()
            
            view.apply {
                $0.backgroundColor = .clear
            }
            
            switch i {
            case 0:
                view.addSubview(lblMinTempTitle)
                view.addSubview(lblMinTemp)
                
                lblMinTempTitle.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).activate()
                }
                
                lblMinTemp.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).activate()
                }
            case 1:
                view.addSubview(lblCurrentTempTitle)
                view.addSubview(lblCurrentTemp)
                
                lblCurrentTempTitle.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).activate()
                }
                
                lblCurrentTemp.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).activate()
                }
            case 2:
                view.addSubview(lblMaxTempTitle)
                view.addSubview(lblMaxTemp)
                
                lblMaxTempTitle.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).activate()
                }
                
                lblMaxTemp.apply {
                    $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).activate()
                    $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).activate()
                }
            default:
                return
            }
            
            stkTemps.addArrangedSubview(view)
            
        }
    }
    
    func setValues(min: Double, current: Double, max: Double) {
        
        lblMinTempTitle.text = "Min"
        lblCurrentTempTitle.text = "Current"
        lblMaxTempTitle.text = "Max"
        
        let units = UserDefaults.standard.string(forKey: UNITS_SETTING) ?? "Metric"
        
        var minTemp = 0.0
        if min != 0.0 {
            if units == "Metric" {
                minTemp = min + KELVIN_CONST
            } else {
                minTemp = (1.8 * (min + KELVIN_CONST)) + 32
            }
        }
        
        var currTemp = 0.0
        if current != 0.0 {
            if units == "Metric" {
                currTemp = current + KELVIN_CONST
            } else {
                currTemp = (1.8 * (current + KELVIN_CONST)) + 32
            }
        }
        
        var maxTemp = 0.0
        if max != 0.0 {
            if units == "Metric" {
                maxTemp = max + KELVIN_CONST
            } else {
                maxTemp = (1.8 * (max + KELVIN_CONST)) + 32
            }
        }
        
        lblMinTemp.text = String(format:"%.2f° \(units == "Metric" ? "C" : "F")",minTemp)
        lblCurrentTemp.text = String(format:"%.2f° \(units == "Metric" ? "C" : "F")",currTemp)
        lblMaxTemp.text = String(format:"%.2f° \(units == "Metric" ? "C" : "F")",maxTemp)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


