//
//  CreateEventScreenView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class CreateEventScreenView: UIView {
    
    // MARK: - Public Properties
    
    public var event: EventModel = EventModelImpl(
        dateStart: Date().timeIntervalSince1970,
        dateFinish: Date().timeIntervalSince1970,
        name: "",
        description: ""
    )
    
    // MARK: - Private Properties
    
    private lazy var nameField: TextField = {
        let field = TextField(
            padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        )
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = R.string.localizable.eventName()
        field.textAlignment = .left
        field.backgroundColor = R.color.greyLight()
        field.layer.cornerRadius = 8
        field.delegate = self
        return field
    }()
    
    private let dateContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.color.greyLight()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.eventStartDate()
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let endLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.eventEndDate()
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let startField: TextField = {
        let field = TextField(
            padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        )
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .left
        field.backgroundColor = R.color.greyLight()
        field.layer.cornerRadius = 8
        field.placeholder = "Время"
        return field
    }()
    
    private let endField: TextField = {
        let field = TextField(
            padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        )
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .left
        field.backgroundColor = R.color.greyLight()
        field.layer.cornerRadius = 8
        field.placeholder = "Время"
        return field
    }()
    
    private let splitLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.color.grey()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var descriptionFiled: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.backgroundColor = R.color.greyLight()
        textView.layer.cornerRadius = 8
        textView.text = R.string.localizable.eventDescription()
        textView.textColor = .lightGray
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = .white
        return picker
    }()
    
    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = .white
        return picker
    }()
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        return formatter
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setSubviews()
        setConstraints()
        setDatePickers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setDatePickers() {
        startField.inputView = startDatePicker
        startField.text = formatter.string(from: startDatePicker.date)
        startDatePicker.addTarget(self, action: #selector(startTimeChanged(_:)), for: .valueChanged)
        startDatePicker.frame.size = CGSize(width: 0, height: 250)
        
        endField.inputView = endDatePicker
        endField.text = formatter.string(from: endDatePicker.date)
        endDatePicker.addTarget(self, action: #selector(startTimeChanged(_:)), for: .valueChanged)
        startDatePicker.frame.size = CGSize(width: 0, height: 250)
    }
    
    @objc private func startTimeChanged(_ sender: UIDatePicker) {
        switch sender {
        case startDatePicker:
            startField.text = formatter.string(from: startDatePicker.date)
            event.dateStart = startDatePicker.date.timeIntervalSince1970
        case endDatePicker:
            endField.text = formatter.string(from: endDatePicker.date)
            event.dateFinish = endDatePicker.date.timeIntervalSince1970
        default:
            return
        }
    }
    
    private func setSubviews() {
        [
            nameField,
            dateContainer,
            startLabel,
            endLabel,
            splitLine,
            startField,
            endField,
            descriptionFiled
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            dateContainer.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            dateContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: dateContainer.topAnchor, constant: 16),
            startLabel.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            splitLine.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 16),
            splitLine.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor, constant: 8),
            splitLine.trailingAnchor.constraint(equalTo: dateContainer.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            endLabel.topAnchor.constraint(equalTo: splitLine.bottomAnchor, constant: 16),
            endLabel.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor, constant: 8),
            endLabel.bottomAnchor.constraint(equalTo: dateContainer.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            startField.centerYAnchor.constraint(equalTo: startLabel.centerYAnchor),
            startField.leadingAnchor.constraint(equalTo: startLabel.trailingAnchor, constant: 16),
            startField.trailingAnchor.constraint(equalTo: dateContainer.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            endField.centerYAnchor.constraint(equalTo: endLabel.centerYAnchor),
            endField.leadingAnchor.constraint(equalTo: endLabel.trailingAnchor, constant: 16),
            endField.trailingAnchor.constraint(equalTo: dateContainer.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionFiled.topAnchor.constraint(equalTo: dateContainer.bottomAnchor, constant: 16),
            descriptionFiled.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionFiled.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension CreateEventScreenView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            event.name = text
        }
    }
}

// MARK: - UITextViewDelegate

extension CreateEventScreenView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = R.string.localizable.eventDescription()
            textView.textColor = .lightGray
        } else {
            event.description = textView.text
        }
    }
}
