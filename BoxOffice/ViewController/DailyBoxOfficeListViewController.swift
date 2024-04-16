//
//  DailyBoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

final class DailyBoxOfficeListViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var boxOffices: [BoxOffice] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOffice>?
    private let networkService: NetworkService
    
    private var selectedDate: Date = .now {
        didSet {
            self.title = selectedDate.formatted(.iso8601FullDate)
            
            collectionView.refreshControl?.beginRefreshing()
            
            self.boxOffices.removeAll()
            self.applySnapshot()
            
            fetchDailyBoxOffices {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        configureDataSource()
        
        setupUI()
        configureRefreshControl()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        guard let yesterdayDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: Date()) else {
            return
        }
        
        selectedDate = yesterdayDate
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeListCell, BoxOffice> { cell, indexPath, model in
            cell.boxOffice = model
            cell.accessories = [
                .disclosureIndicator(displayed: .always)
            ]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOffice>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOffice) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOffice>()
        snapshot.appendSections([.main])
        snapshot.appendItems(boxOffices)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func fetchDailyBoxOffices(completion: (() -> Void)?) {
        networkService.request(url: APIs.Kobis.BoxOffice.dailyList.url,
                               queryParameters: [
                                "key": Environment.apiKey,
                                "targetDt": selectedDate.formatted(.iso8601FullDateWithoutSeparator)]
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let responseDTO = try JSONDecoder().decode(DailyBoxOfficeResponseDTO.self, from: data)
                    
                    self.boxOffices = responseDTO.boxOfficeResult.dailyBoxOfficeList.map {
                        $0.toModel()
                    }
                    
                    DispatchQueue.main.async {
                        self.applySnapshot()
                        self.collectionView.refreshControl?.endRefreshing()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.present(AlertFactory.alert(for: error), animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(AlertFactory.alert(for: error), animated: true)
                }
            }
        }
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        guard let yesterdayDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: Date()) else {
            return
        }
        
        selectedDate = yesterdayDate
    }
    
    @objc private func presentCalendar() {
        let calendarViewController = CalendarViewController(selectedDate: selectedDate)
        self.present(calendarViewController, animated: true)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "날짜선택",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(presentCalendar))
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension DailyBoxOfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
