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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                showSelectedCircle()
            } else {
                hideSelectedCircle()
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = R.font.montserratMedium(size: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let selectedCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.circleFill()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        imageView.alpha = 0.0
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setSubviews() {
        addSubview(selectedCircle)
        addSubview(dayLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectedCircle.topAnchor.constraint(equalTo: topAnchor),
            selectedCircle.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedCircle.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedCircle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func showSelectedCircle() {
        UIView.animate(
            withDuration: 0.4,
            animations: { [weak self] in
                self?.selectedCircle.alpha = 0.5
            }
        )
    }
    
    private func hideSelectedCircle() {
        UIView.animate(
            withDuration: 0.4,
            animations: { [weak self] in
                self?.selectedCircle.alpha = 0.0
            }
        )
    }
}
