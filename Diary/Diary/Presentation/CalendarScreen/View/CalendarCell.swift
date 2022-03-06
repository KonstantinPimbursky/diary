//
//  CalendarCell.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static var reuseIdentifier: String {
        return String(describing: CalendarCell.self)
    }
    
    public var text: String = "" {
        didSet {
            dayLabel.text = text
        }
    }
    
    // MARK: - Private Properties
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = R.font.montserratMedium(size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setConstraints() {
        addSubview(dayLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
