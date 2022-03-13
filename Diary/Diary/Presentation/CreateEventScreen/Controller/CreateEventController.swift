//
//  CreateEventController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 13.03.2022.
//

import UIKit

protocol CreateEventControllerDelegate: AnyObject {
    func eventWasSaved()
}

final class CreateEventController: UIViewController {
    
    // MARK: - Public Properties
    
    public weak var delegate: CreateEventControllerDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var startLabel: UILabel!
    @IBOutlet private var endLabel: UILabel!
    @IBOutlet private var descriptionFiled: UITextView!
    @IBOutlet private var startDatePicker: UIDatePicker!
    @IBOutlet private var endDatePicker: UIDatePicker!
    
    // MARK: - Private Properties
    
    private var eventHasChanges: Bool {
        return nameWasAdded || descriptionWasAdded
    }
    
    private var nameWasAdded: Bool = false {
        didSet {
            changesSaveItemActivity()
        }
    }
    
    private var descriptionWasAdded: Bool = false {
        didSet {
            changesSaveItemActivity()
        }
    }
    
    private let realmManager = RealmManager()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupNameField()
        setupStartLabel()
        setupEndLabel()
        setupDescriptionField()
    }
    
    // MARK: - IBActions
    
    @IBAction private func startDatePickerChanged() {
        endDatePicker.minimumDate = startDatePicker.date
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelAction)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveAction)
        )
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.title = R.string.localizable.eventTitle()
    }
    
    private func setupNameField() {
        nameField.placeholder = R.string.localizable.eventName()
        nameField.textAlignment = .left
        nameField.backgroundColor = R.color.greyLight()
        nameField.layer.cornerRadius = 8
        nameField.clearButtonMode = .whileEditing
        nameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupStartLabel() {
        startLabel.text = R.string.localizable.eventStartDate()
        startLabel.textAlignment = .left
    }
    
    private func setupEndLabel() {
        endLabel.text = R.string.localizable.eventEndDate()
        endLabel.textAlignment = .left
    }
    
    private func setupDescriptionField() {
        descriptionFiled.textAlignment = .left
        descriptionFiled.backgroundColor = R.color.greyLight()
        descriptionFiled.layer.cornerRadius = 8
        descriptionFiled.text = R.string.localizable.eventDescription()
        descriptionFiled.textColor = .lightGray
        descriptionFiled.delegate = self
        descriptionFiled.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        descriptionFiled.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func changesSaveItemActivity() {
        navigationItem.rightBarButtonItem?.isEnabled = eventHasChanges
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: nil,
            message: R.string.localizable.eventWarningMessage(),
            preferredStyle: .actionSheet
        )
        let continueEditingAction = UIAlertAction(
            title: R.string.localizable.eventContinueEditing(),
            style: .cancel
        )
        let cancelChangesAction = UIAlertAction(
            title: R.string.localizable.eventCancelChanges(),
            style: .default,
            handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        )
        alertController.addAction(continueEditingAction)
        alertController.addAction(cancelChangesAction)
        present(alertController, animated: true)
    }
}

// MARK: - Actions

extension CreateEventController {
    @objc private func cancelAction() {
        if eventHasChanges {
            showAlert()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc private func saveAction() {
        guard let eventName = nameField.text else { return }
        realmManager.saveEvent(
            id: UUID().uuidString,
            dateStart: startDatePicker.date.timeIntervalSince1970,
            dateFinish: endDatePicker.date.timeIntervalSince1970,
            eventName: eventName,
            eventDescription: descriptionFiled.text
        )
        delegate?.eventWasSaved()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = nameField.text else { return }
        if text.isEmpty {
            nameWasAdded = false
        } else {
            nameWasAdded = true
        }
    }
}

// MARK: - UITextViewDelegate

extension CreateEventController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            descriptionWasAdded = false
            textView.text = R.string.localizable.eventDescription()
            textView.textColor = .lightGray
        } else {
            descriptionWasAdded = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            descriptionWasAdded = false
        } else {
            descriptionWasAdded = true
        }
    }
}
