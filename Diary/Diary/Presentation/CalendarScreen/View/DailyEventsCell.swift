//
//  DailyEventsCell.swift
//  Diary
//
//  Created by Konstantin Pimbursky on 06.03.2022.
//

import UIKit

final class DailyEventsCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static var reuseIdentifier: String {
        return String(describing: DailyEventsCell.self)
    }
    
    public var timeText: String = "" {
        didSet {
            timeLabel.text = timeText
        }
    }
    
    // MARK: - Private Properties
    
    private var events = [EventModel]()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        events = []
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Public Methods
    
    public func addEvent(
        _ event: EventModel,
        tag: Int,
        target: Any?,
        action: Selector,
        control: UIControl.Event
    ) {
        let startDateString = dateFormatter.string(from: event.dateStart)
        let endDateString = dateFormatter.string(from: event.dateFinish)
        let timeString = startDateString + " - " + endDateString
        let eventView = EventView(name: event.name, time: timeString)
        events.append(event)
        eventView.tag = tag
        eventView.addTarget(target, action: action, for: control)
        stackView.addArrangedSubview(eventView)
    }
    
    // MARK: - Private Methods
    
    private func setSubviews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            timeLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
}
