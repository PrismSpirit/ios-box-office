//
//  DailyBoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class DailyBoxOfficeListViewController: UIViewController {
    private var boxOffices: [BoxOffice] = []
    
    private var yesterdayDate: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    private let collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DailyBoxOfficeListCell.self, forCellWithReuseIdentifier: DailyBoxOfficeListCell.identifier)
        
        return collectionView
    }()
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = yesterdayDate.ISO8601Format(.iso8601FullDate)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        configureRefreshControl()
        setConstraints()
        
        fetchDailyBoxOffices()
    }
    
    private func fetchDailyBoxOffices() {
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
                        self.collectionView.reloadData()
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
        fetchDailyBoxOffices()
        
        DispatchQueue.main.async {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func setConstraints() {
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

extension DailyBoxOfficeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boxOffices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeListCell.identifier, for: indexPath) as? DailyBoxOfficeListCell else {
            return UICollectionViewCell()
        }
        
        cell.updateComponents(with: boxOffices[indexPath.row])
        
        return cell
    }
}
