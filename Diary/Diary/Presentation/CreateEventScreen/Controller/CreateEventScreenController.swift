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
    
}
