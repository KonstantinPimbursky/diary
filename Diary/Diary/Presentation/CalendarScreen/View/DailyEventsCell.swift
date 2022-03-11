//
//  DailyEventsCell.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class DailyEventsCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static var reuseIdentifier: String {
        return String(describing: DailyEventsCell.self)
    }
    
    public var timeText: String = "" {
        didSet {
            timeLabel.text = timeText
        }
    }
    
    // MARK: - Private Properties
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.montserratMedium(size: 12)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setSubviews() {
        addSubview(timeLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            timeLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
