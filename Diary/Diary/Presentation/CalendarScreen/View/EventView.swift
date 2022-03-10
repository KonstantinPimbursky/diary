//
//  EventView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 10.03.2022.
//

import UIKit

final class EventView: UIView {
    
    // MARK: - Public Properties
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.6332009249, blue: 0.6391848169, alpha: 1)
        return label
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0.6332009249, blue: 0.6391848169, alpha: 1)
        return label
    }()
    
    // MARK: - Private Properties
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.4)
        return stack
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(timeLabel)
        addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
}
