//
//  DailyBoxOfficeListCell.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/10/24.
//

import UIKit

class DailyBoxOfficeListCell: UICollectionViewListCell {
    static let identifier = "DailyBoxOfficeListCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private func setupUI() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankingChangeLabel)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(audienceLabel)
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalToConstant: 48),
            rankStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            rankStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            rankStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            infoStackView.leadingAnchor.constraint(equalTo: rankStackView.trailingAnchor, constant: 16),
            infoStackView.centerYAnchor.constraint(equalTo: rankStackView.centerYAnchor),
        ])
    }
    
    func updateComponents(with model: BoxOffice) {
        rankLabel.text = model.rank
    
        switch model.rankingEntry {
        case .old:
            rankingChangeLabel.attributedText = convertChangeToAttributedString(amount: Int(model.rankChange))
        case .new:
            rankingChangeLabel.text = "신규"
            rankingChangeLabel.textColor = .systemPink
        }
        
        titleLabel.text = model.title
        audienceLabel.text = "오늘 \(model.todayAudience) / 총 \(model.totalAudience)"
    }
    
    private func convertChangeToAttributedString(amount: Int?) -> NSAttributedString {
        guard let amount, amount != 0 else {
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
