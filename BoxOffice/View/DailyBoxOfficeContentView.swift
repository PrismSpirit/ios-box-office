//
//  DailyBoxOfficeContentView.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/12/24.
//

import UIKit

class DailyBoxOfficeContentView: UIView, UIContentView, AttributedStringConvertable {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    let rankingChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let audienceInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateConfiguration() {
        guard let configuration = configuration as? DailyBoxOfficeConfiguration,
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
}

final class DailyBoxOfficeListContentView: DailyBoxOfficeContentView {
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
    
    override init(configuration: UIContentConfiguration) {
        super.init(configuration: configuration)
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
}

final class DailyBoxOfficeGridContentView: DailyBoxOfficeContentView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(configuration: UIContentConfiguration) {
        super.init(configuration: configuration)
        setupUI()
        updateConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(gray: 0.5, alpha: 1.0)
        
        rankLabel.adjustsFontSizeToFitWidth = true
        rankingChangeLabel.adjustsFontSizeToFitWidth = true
        titleLabel.adjustsFontSizeToFitWidth = true
        audienceInfoLabel.adjustsFontSizeToFitWidth = true
        
        rankLabel.textAlignment = .center
        rankingChangeLabel.textAlignment = .center
        titleLabel.textAlignment = .center
        audienceInfoLabel.textAlignment = .center
        
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(rankingChangeLabel)
        stackView.addArrangedSubview(audienceInfoLabel)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

protocol AttributedStringConvertable {
    func convertChangeToAttributedString(amount: Int) -> NSAttributedString
}

extension AttributedStringConvertable {
    func convertChangeToAttributedString(amount: Int) -> NSAttributedString {
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
