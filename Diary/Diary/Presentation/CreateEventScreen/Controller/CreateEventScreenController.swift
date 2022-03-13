//
//  CreateEventScreenController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

protocol CreateEventScreenControllerDelegate: AnyObject {
    func eventWasSaved()
}

final class CreateEventScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var delegate: CreateEventScreenControllerDelegate?
    private lazy var mainView = CreateEventScreenView(delegate: self)
    private let realmManager = RealmManager()
    private var eventHasChanges: Bool = false {
        didSet {
            navigationItem.rightBarButtonItem?.isEnabled = eventHasChanges
        }
    }
    
    // MARK: - Initializers
    
    init(delegate: CreateEventScreenControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
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
    
    @objc private func cancelAction() {
        if eventHasChanges {
            showAlert()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc private func saveAction() {
        realmManager.saveEvent(
            id: mainView.event.id.uuidString,
            dateStart: mainView.event.dateStart.timeIntervalSince1970,
            dateFinish: mainView.event.dateFinish.timeIntervalSince1970,
            eventName: mainView.event.name,
            eventDescription: mainView.event.description
        )
        delegate?.eventWasSaved()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CreateEventScreenViewDelegate

extension CreateEventScreenController: CreateEventScreenViewDelegate {
    func createEventScreenView(hasChanges: Bool) {
        
        eventHasChanges = hasChanges
    }
}
