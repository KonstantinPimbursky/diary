//
//  CreateEventScreenController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class CreateEventScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = CreateEventScreenView()
    
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
        navigationItem.title = R.string.localizable.eventTitle()
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        print("saveAction")
    }
}
