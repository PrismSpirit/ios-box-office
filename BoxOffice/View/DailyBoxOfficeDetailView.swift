//
//  DailyBoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

class DailyBoxOfficeDetailView: UIScrollView {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let directorsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let directorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let directorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let productionYearTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작년도"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let productionYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let productionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let openDateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개봉일"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let openDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let runningTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "상영시간"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let runningTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let runningTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let watchGradeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관람등급"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let watchGradeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let watchGradeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let nationsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작국가"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let nationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let nationsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let genreTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "장르"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let actorsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배우"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let actorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .systemBackground
        
        directorsStackView.addArrangedSubview(directorsTitleLabel)
        directorsStackView.addArrangedSubview(directorsLabel)
        productionStackView.addArrangedSubview(productionYearTitleLabel)
        productionStackView.addArrangedSubview(productionYearLabel)
        openDateStackView.addArrangedSubview(openDateTitleLabel)
        openDateStackView.addArrangedSubview(openDateLabel)
        runningTimeStackView.addArrangedSubview(runningTimeTitleLabel)
        runningTimeStackView.addArrangedSubview(runningTimeLabel)
        watchGradeStackView.addArrangedSubview(watchGradeTitleLabel)
        watchGradeStackView.addArrangedSubview(watchGradeLabel)
        nationsStackView.addArrangedSubview(nationsTitleLabel)
        nationsStackView.addArrangedSubview(nationsLabel)
        genreStackView.addArrangedSubview(genreTitleLabel)
        genreStackView.addArrangedSubview(genreLabel)
        actorsStackView.addArrangedSubview(actorsTitleLabel)
        actorsStackView.addArrangedSubview(actorsLabel)
        
        contentStackView.addArrangedSubview(directorsStackView)
        contentStackView.addArrangedSubview(productionStackView)
        contentStackView.addArrangedSubview(openDateStackView)
        contentStackView.addArrangedSubview(runningTimeStackView)
        contentStackView.addArrangedSubview(watchGradeStackView)
        contentStackView.addArrangedSubview(nationsStackView)
        contentStackView.addArrangedSubview(genreStackView)
        contentStackView.addArrangedSubview(actorsStackView)
        
        self.addSubview(imageView)
        self.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            directorsTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            productionYearTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            openDateTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            runningTimeTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            watchGradeTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            nationsTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            genreTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            actorsTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            
            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: frameLayoutGuide.widthAnchor)
        ])
    }
    
    func updateImageContent(image: UIImage) {
        imageView.image = image
    }
    
    func updateMovieDetailContent(data: MovieDetail) {
        directorsLabel.text = data.directors.joined(separator: ", ")
        productionYearLabel.text = String(data.productionYear)
        openDateLabel.text = data.openDate
        runningTimeLabel.text = String(data.showTime)
        watchGradeLabel.text = data.watchGrade.joined(separator: ", ")
        nationsLabel.text = data.nations.joined(separator: ", ")
        genreLabel.text = data.genres.joined(separator: ", ")
        actorsLabel.text = data.actors.joined(separator: ", ")
        
    }
}
