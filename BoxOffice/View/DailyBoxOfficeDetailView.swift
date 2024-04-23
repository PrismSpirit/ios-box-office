//
//  DailyBoxOfficeDetailView.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

class DailyBoxOfficeDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let directorsConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let directorsVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let productionYearConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작년도"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let productionYearVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let openDateConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개봉일"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let openDateVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let runningTimeConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "상영시간"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let runningTimeVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let watchGradeConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관람등급"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let watchGradeVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let nationsConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작국가"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let nationsVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let genreConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "장르"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let genreVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let actorsConstantLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배우"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let actorsVariableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
        
        contentView.addSubview(imageView)
        contentView.addSubview(directorsConstantLabel)
        contentView.addSubview(directorsVariableLabel)
        contentView.addSubview(productionYearConstantLabel)
        contentView.addSubview(productionYearVariableLabel)
        contentView.addSubview(openDateConstantLabel)
        contentView.addSubview(openDateVariableLabel)
        contentView.addSubview(runningTimeConstantLabel)
        contentView.addSubview(runningTimeVariableLabel)
        contentView.addSubview(watchGradeConstantLabel)
        contentView.addSubview(watchGradeVariableLabel)
        contentView.addSubview(nationsConstantLabel)
        contentView.addSubview(nationsVariableLabel)
        contentView.addSubview(genreConstantLabel)
        contentView.addSubview(genreVariableLabel)
        contentView.addSubview(actorsConstantLabel)
        contentView.addSubview(actorsVariableLabel)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        
        productionYearConstantLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        directorsVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        productionYearVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        openDateVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        runningTimeVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        watchGradeVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nationsVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        genreVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        actorsVariableLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            directorsConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            openDateConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            runningTimeConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            watchGradeConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            nationsConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            genreConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            actorsConstantLabel.widthAnchor.constraint(equalTo: productionYearConstantLabel.widthAnchor),
            
            directorsConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            openDateConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            runningTimeConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            watchGradeConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            nationsConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            genreConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            actorsConstantLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.leadingAnchor),
            
            productionYearConstantLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            directorsConstantLabel.centerYAnchor.constraint(equalTo: directorsVariableLabel.centerYAnchor),
            productionYearConstantLabel.centerYAnchor.constraint(equalTo: productionYearVariableLabel.centerYAnchor),
            openDateConstantLabel.centerYAnchor.constraint(equalTo: openDateVariableLabel.centerYAnchor),
            runningTimeConstantLabel.centerYAnchor.constraint(equalTo: runningTimeVariableLabel.centerYAnchor),
            watchGradeConstantLabel.centerYAnchor.constraint(equalTo: watchGradeVariableLabel.centerYAnchor),
            nationsConstantLabel.centerYAnchor.constraint(equalTo: nationsVariableLabel.centerYAnchor),
            genreConstantLabel.centerYAnchor.constraint(equalTo: genreVariableLabel.centerYAnchor),
            actorsConstantLabel.centerYAnchor.constraint(equalTo: actorsVariableLabel.centerYAnchor),
            
            directorsVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: directorsConstantLabel.heightAnchor),
            productionYearVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: productionYearConstantLabel.heightAnchor),
            openDateVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: openDateConstantLabel.heightAnchor),
            runningTimeVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: runningTimeConstantLabel.heightAnchor),
            watchGradeVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: watchGradeConstantLabel.heightAnchor),
            nationsVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: nationsConstantLabel.heightAnchor),
            genreVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: genreConstantLabel.heightAnchor),
            actorsVariableLabel.heightAnchor.constraint(greaterThanOrEqualTo: actorsConstantLabel.heightAnchor),
            
            directorsVariableLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            productionYearVariableLabel.topAnchor.constraint(equalTo: directorsVariableLabel.bottomAnchor, constant: 8),
            openDateVariableLabel.topAnchor.constraint(equalTo: productionYearVariableLabel.bottomAnchor, constant: 8),
            runningTimeVariableLabel.topAnchor.constraint(equalTo: openDateVariableLabel.bottomAnchor, constant: 8),
            watchGradeVariableLabel.topAnchor.constraint(equalTo: runningTimeVariableLabel.bottomAnchor, constant: 8),
            nationsVariableLabel.topAnchor.constraint(equalTo: watchGradeVariableLabel.bottomAnchor, constant: 8),
            genreVariableLabel.topAnchor.constraint(equalTo: nationsVariableLabel.bottomAnchor, constant: 8),
            actorsVariableLabel.topAnchor.constraint(equalTo: genreVariableLabel.bottomAnchor, constant: 8),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: actorsVariableLabel.bottomAnchor),
            
            directorsVariableLabel.leadingAnchor.constraint(equalTo: productionYearVariableLabel.leadingAnchor),
            openDateVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            runningTimeVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            watchGradeVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            nationsVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            genreVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            actorsVariableLabel.leadingAnchor.constraint(equalTo: directorsVariableLabel.leadingAnchor),
            
            productionYearVariableLabel.leadingAnchor.constraint(equalTo: productionYearConstantLabel.trailingAnchor, constant: 8),
            
            productionYearVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            openDateVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            runningTimeVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            watchGradeVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            nationsVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            genreVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            actorsVariableLabel.trailingAnchor.constraint(equalTo: directorsVariableLabel.trailingAnchor),
            
            productionYearVariableLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func updateImageContent(image: UIImage) {
        let ratio = image.size.height / image.size.width
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio),
        ])
        
        imageView.image = image
    }
    
    func updateMovieDetailContent(data: MovieDetail) {
        directorsVariableLabel.text = data.directors
        productionYearVariableLabel.text = String(data.productionYear)
        openDateVariableLabel.text = data.openDate
        runningTimeVariableLabel.text = String(data.showTime)
        watchGradeVariableLabel.text = data.watchGrade
        nationsVariableLabel.text = data.nations
        genreVariableLabel.text = data.genres
        actorsVariableLabel.text = data.actors
    }
}
