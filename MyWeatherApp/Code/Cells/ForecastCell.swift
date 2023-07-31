//
//  ForecastCell.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import UIKit

class ForecastCell: ReusableTableViewCell {
    
    // MARK: - Properties
    
    let dayLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.textAlignment = .left
        lbl.textColor = .white
        return lbl
    }()
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    let degreesLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lbl.textAlignment = .right
        lbl.textColor = .white
        return lbl
    }()
    
    let itemsStack: UIStackView = {
        let stk = UIStackView()
        stk.axis = .horizontal
        stk.distribution = .fillProportionally
        stk.alignment = .fill
        stk.spacing = 16
        return stk
    }()
    
    private var viewModel: ForecastCellVM!
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(itemsStack)

        itemsStack.manualLayoutable()
        itemsStack.apply {
            $0.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        }
        
        itemsStack.addArrangedSubview(dayLabel)
        itemsStack.addArrangedSubview(iconImageView)
        itemsStack.addArrangedSubview(degreesLabel)
        
        dayLabel.widthAnchor.constraint(equalToConstant: ((bounds.width - 40)/3) * 2).activate()
        iconImageView.widthAnchor.constraint(equalToConstant: 40).activate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell(viewModel: ForecastCellVM) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        
        let relativeDateFormatter = DateFormatter()
        relativeDateFormatter.timeStyle = .short
        relativeDateFormatter.dateStyle = .short
        relativeDateFormatter.locale = Locale(identifier: "en_GB")
        relativeDateFormatter.doesRelativeDateFormatting = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: viewModel.dayOfWeek ?? "") {
            dayLabel.text = relativeDateFormatter.string(from: date)
        }
        iconImageView.image = AllMethods.get_weather_icon(name: viewModel.icon ?? "")
        
        let units = UserDefaults.standard.string(forKey: UNITS_SETTING) ?? "Metric"
        
        var tempInDegrees = 0.0
        if units == "Metric" {
            tempInDegrees = (viewModel.temp ?? 0.00) + KELVIN_CONST
        } else {
            tempInDegrees = (1.8 * ((viewModel.temp ?? 0.00) + KELVIN_CONST)) + 32
        }
        
        degreesLabel.text = String(format:"%.2f° \(units == "Metric" ? "C" : "F")",tempInDegrees)
    }
    
    // MARK: - Handlers
    
}
