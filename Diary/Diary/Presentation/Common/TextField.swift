//
//  TextField.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class TextField: UITextField {
    
    // MARK: - Private Properties
    
    private let padding: UIEdgeInsets
    
    // MARK: - Initializers
    
    init(padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
