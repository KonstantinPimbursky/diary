//
//  CreateEventScreenView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class CreateEventScreenView: UIView {
    
    // MARK: - Private Properties
    
    private let nameField: TextField = {
        let field = TextField(
            padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        )
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 14)
        field.placeholder = R.string.localizable.eventName()
        field.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        return field
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setSubviews() {
        addSubview(nameField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
}
