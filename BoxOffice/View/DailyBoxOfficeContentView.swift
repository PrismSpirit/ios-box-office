//
//  DailyBoxOfficeContentView.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/12/24.
//

import UIKit

final class DailyBoxOfficeContentView: UIView, UIContentView {
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
