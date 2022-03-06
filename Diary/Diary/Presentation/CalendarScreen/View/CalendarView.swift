//
//  CalendarView.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 03.03.2022.
//

import UIKit

protocol CalendarViewDelegate: AnyObject {
    func previousMonthButtonTapped()
    func nextMonthButtonTapped()
}

final class CalendarView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: CalendarViewDelegate?
    
    public let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Февраль 2022"
        label.textColor = .black
        label.textAlignment = .center
        label.font = R.font.montserratMedium(size: 20)
        return label
    }()
    
    public let monthCollectionView: UICollectionView = {
        let lineSpacing: CGFloat = 2
        let itemSpacing: CGFloat = 2
        let cellWidth = (UIScreen.main.bounds.width - 2 * itemSpacing - 6 * itemSpacing) / 7
        let celSize = CGSize(width: cellWidth, height: cellWidth)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.scrollDirection = .vertical
        layout.itemSize = celSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 0, left: itemSpacing, bottom: 0, right: itemSpacing)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(
            CalendarCell.self,
            forCellWithReuseIdentifier: CalendarCell.reuseIdentifier
        )
        let height = cellWidth * 6 + lineSpacing * 5
        collection.heightAnchor.constraint(equalToConstant: height).isActive = true
        return collection
    }()
    
    public let dayEventsTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Private Properties
    
    private let previousMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.arrowLeftFill(), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let nextMonthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.arrowRightFill(), for: .normal)
        button.tintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let weekStackView: WeekStackView = {
        let stack = WeekStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    // MARK: - Initializers
    
    init(subscriber: CalendarViewDelegate?) {
        self.delegate = subscriber
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setConstraints()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupButtonActions() {
        [
            previousMonthButton,
            nextMonthButton
        ].forEach { $0.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside) }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case previousMonthButton:
            delegate?.previousMonthButtonTapped()
        case nextMonthButton:
            delegate?.nextMonthButtonTapped()
        default:
            break
        }
    }
}

// MARK: - Layout

extension CalendarView {
    private func addSubviews() {
        [
            previousMonthButton,
            nextMonthButton,
            monthLabel,
            weekStackView,
            monthCollectionView
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            previousMonthButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            previousMonthButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            nextMonthButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nextMonthButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            monthLabel.centerYAnchor.constraint(equalTo: previousMonthButton.centerYAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: previousMonthButton.trailingAnchor, constant: 16),
            monthLabel.trailingAnchor.constraint(equalTo: nextMonthButton.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            weekStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 16),
            weekStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weekStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            monthCollectionView.topAnchor.constraint(equalTo: weekStackView.bottomAnchor),
            monthCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            monthCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
