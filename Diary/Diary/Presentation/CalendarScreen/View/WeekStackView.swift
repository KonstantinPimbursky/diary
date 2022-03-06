//
//  WeekStackView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import UIKit

final class WeekStackView: UIStackView {
    
    // MARK: - Private Properties
    
    private let fontSize = 14
    
    private let mondayLabel: UILabel = {
        let label = UILabel()
        label.text = "Пн"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let tuesdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let wednesdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Ср"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let thursdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Чт"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let fridayLabel: UILabel = {
        let label = UILabel()
        label.text = "Пт"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        return label
    }()
    
    private let saturdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сб"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .gray
        return label
    }()
    
    private let sundayLabel: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        addArrangedSubviews([
            mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel, sundayLabel
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
