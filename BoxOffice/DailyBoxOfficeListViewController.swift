//
//  DailyBoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class DailyBoxOfficeListViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var boxOffices: [BoxOffice] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOffice>?
    private let networkService = NetworkService()
    
    private var yesterdayDate: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    private let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = yesterdayDate.ISO8601Format(.iso8601FullDate)
        
        collectionView.delegate = self
        configureDataSource()
        
        setupUI()
        configureRefreshControl()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        collectionView.refreshControl?.beginRefreshing()
        
        fetchDailyBoxOffices(completion: nil)
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
                                "targetDt": yesterdayDate.formatted(.iso8601FullDateWithoutSeparator)]
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
                        let alertController = UIAlertController(title: "Data Decoding Error",
                                                                message: error.localizedDescription,
                                                                preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
                        
                        self.present(alertController, animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Network Error",
                                                            message: error.localizedDescription,
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Confirm", style: .default))
                    
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        fetchDailyBoxOffices {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension DailyBoxOfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
