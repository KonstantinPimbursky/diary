//
//  DetailsScreenController.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 11.03.2022.
//

import UIKit

final class DetailsScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = DetailsScreenView()
    private let eventModel: EventModel
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, dd.MM.yyyy"
        return formatter
    }()
    
    // MARK: - Initializers
    
    init(eventModel: EventModel) {
        self.eventModel = eventModel
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
        mainView.nameLabel.text = eventModel.name
        let startDateString = R.string.localizable.detailsFrom() + " " + formatter.string(from: eventModel.dateStart)
        let endDateString = R.string.localizable.detailsTo() + " " + formatter.string(from: eventModel.dateFinish)
        mainView.startLabel.text = startDateString
        mainView.endLabel.text = endDateString
        mainView.descriptionLabel.text = eventModel.description
    }
}
