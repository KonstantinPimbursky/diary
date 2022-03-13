//
//  DetailsScreenController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 11.03.2022.
//

import UIKit

protocol DetailsScreenControllerDelegate: AnyObject {
    func deleteButtonWasTapped()
}

final class DetailsScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var delegate: DetailsScreenControllerDelegate?
    private lazy var mainView = DetailsScreenView(delegate: self)
    private let event: EventModel
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, dd.MM.yyyy"
        return formatter
    }()
    private let realmManager = RealmManager()
    
    // MARK: - Initializers
    
    init(
        eventModel: EventModel,
        delegate: DetailsScreenControllerDelegate?
    ) {
        self.event = eventModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        fillLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    // MARK: - Private Methods
    
    private func fillLabels() {
        mainView.nameLabel.text = event.name
        let startDateString = R.string.localizable.detailsFrom() + " " + formatter.string(from: event.dateStart)
        let endDateString = R.string.localizable.detailsTo() + " " + formatter.string(from: event.dateFinish)
        mainView.startLabel.text = startDateString
        mainView.endLabel.text = endDateString
        mainView.descriptionLabel.text = event.description
    }
    
    private func showAlert() {
        let alertController = UIAlertController(
            title: nil,
            message: R.string.localizable.detailsWarningMessage(),
            preferredStyle: .actionSheet
        )
        let continueEditingAction = UIAlertAction(
            title: R.string.localizable.detailsCancel(),
            style: .cancel
        )
        let cancelChangesAction = UIAlertAction(
            title: R.string.localizable.detailsDeleteEvent(),
            style: .default,
            handler: { [weak self] _ in
                guard let self = self else { return }
                self.deleteEvent()
            }
        )
        alertController.addAction(continueEditingAction)
        alertController.addAction(cancelChangesAction)
        present(alertController, animated: true)
    }
    
    private func deleteEvent() {
        realmManager.deleteEvent(id: event.id.uuidString)
        delegate?.deleteButtonWasTapped()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - DetailsScreenViewDelegate

extension DetailsScreenController: DetailsScreenViewDelegate {
    func deleteButtonWasTapped() {
        showAlert()
    }
}
