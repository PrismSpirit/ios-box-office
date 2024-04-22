//
//  DailyBoxOfficeContentView.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/12/24.
//

import UIKit

final class DailyBoxOfficeListContentView: UIView, UIContentView {
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let rankingChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let audienceInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            updateConfiguration()
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupUI()
        updateConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankingChangeLabel)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(audienceInfoLabel)
        
        self.addSubview(rankStackView)
        self.addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalToConstant: 56),
            rankStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            rankStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            rankStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            infoStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 16),
            infoStackView.centerYAnchor.constraint(equalTo: rankStackView.centerYAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    private func updateConfiguration() {
        guard let configuration = configuration as? DailyBoxOfficeListConfiguration,
              let boxOffice = configuration.boxOffice else {
            return
        }
        
        rankLabel.text = String(boxOffice.rank)
        
        switch boxOffice.rankingEntry {
        case .old:
            rankingChangeLabel.textColor = .label
            rankingChangeLabel.attributedText = convertChangeToAttributedString(amount: boxOffice.rankChange)
        case .new:
            rankingChangeLabel.text = "신작"
            rankingChangeLabel.textColor = .systemPink
        }
        
        titleLabel.text = boxOffice.title
        
        let thousandSeparatedTodayAudience = boxOffice.todayAudience.formatted(.number)
        let thousandSeparatedTotalAudience = boxOffice.totalAudience.formatted(.number)
        audienceInfoLabel.text = "오늘 \(thousandSeparatedTodayAudience) / 총 \(thousandSeparatedTotalAudience)"
    }
    
    private func convertChangeToAttributedString(amount: Int) -> NSAttributedString {
        guard amount != 0 else {
            return NSAttributedString(string: "-")
        }
        
        let attributedString: NSMutableAttributedString
        
        if amount > 0 {
            attributedString = NSMutableAttributedString(string: "▲",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else {
            attributedString = NSMutableAttributedString(string: "▼",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        }
        
        attributedString.append(NSAttributedString(string: String(abs(amount))))
        
        return attributedString
    }
}

final class DailyBoxOfficeGridContentView: UIView, UIContentView {
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let rankingChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let audienceInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var configuration: UIContentConfiguration {
        didSet {
            updateConfiguration()
        }
    }
    
    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .infinite)
        setupUI()
        updateConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(rankLabel)
        self.addSubview(rankingChangeLabel)
        self.addSubview(titleLabel)
        self.addSubview(audienceInfoLabel)
        
        NSLayoutConstraint.activate([
            rankLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rankingChangeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            audienceInfoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            rankLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 32),
            rankingChangeLabel.bottomAnchor.constraint(equalTo: audienceInfoLabel.topAnchor, constant: -8),
            audienceInfoLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor),
            audienceInfoLabel.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor),
        ])
    }
    
    private func updateConfiguration() {
        guard let configuration = configuration as? DailyBoxOfficeGridConfiguration,
              let boxOffice = configuration.boxOffice else {
            return
        }
        
        rankLabel.text = String(boxOffice.rank)
        
        switch boxOffice.rankingEntry {
        case .old:
            rankingChangeLabel.textColor = .label
            rankingChangeLabel.attributedText = convertChangeToAttributedString(amount: boxOffice.rankChange)
        case .new:
            rankingChangeLabel.text = "신작"
            rankingChangeLabel.textColor = .systemPink
        }
        
        titleLabel.text = boxOffice.title
        
        let thousandSeparatedTodayAudience = boxOffice.todayAudience.formatted(.number)
        let thousandSeparatedTotalAudience = boxOffice.totalAudience.formatted(.number)
        audienceInfoLabel.text = "오늘 \(thousandSeparatedTodayAudience) / 총 \(thousandSeparatedTotalAudience)"
    }
    
    private func convertChangeToAttributedString(amount: Int) -> NSAttributedString {
        guard amount != 0 else {
            return NSAttributedString(string: "-")
        }
        
        let attributedString: NSMutableAttributedString
        
        if amount > 0 {
            attributedString = NSMutableAttributedString(string: "▲",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        } else {
            attributedString = NSMutableAttributedString(string: "▼",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        }
        
        attributedString.append(NSAttributedString(string: String(abs(amount))))
        
        return attributedString
    }
}
