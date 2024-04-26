//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

enum ScreenMode {
    case list
    case grid
}

final class DailyBoxOfficeViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var screenMode: ScreenMode = .list
    private var boxOffices: [BoxOffice] = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOffice>?
    private let networkService: NetworkService
    private var selectedDate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: -1, to: Date()) ?? .now
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: LayoutManager.layout(screenMode: screenMode))
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
        
        configureRefreshControl()
        configureToolBar()
        configureDataSource(to: screenMode)
        collectionView.setCollectionViewLayout(LayoutManager.layout(screenMode: screenMode), animated: false)
        applySnapshot()
        
        setupUI()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        if boxOffices.isEmpty {
            handleRefreshControl()
        }
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
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    private func configureToolBar() {
        navigationController?.isToolbarHidden = false
        
        let screenmodeButton = UIBarButtonItem(title: "화면 모드 변경",
                                               style: .plain,
                                               target: self,
                                               action: #selector(presentLayoutChangeActionSheet))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barItems = [flexibleSpace, screenmodeButton, flexibleSpace]
        self.setToolbarItems(barItems, animated: true)
    }

    private func configureDataSource(to layout: ScreenMode) {
        let cellRegistration = UICollectionView.CellRegistration<DailyBoxOfficeCell, BoxOffice> { cell, indexPath, model in
            cell.boxOffice = model
            switch layout {
            case .list:
                cell.screenMode = .list
                cell.accessories = [
                    .disclosureIndicator(displayed: .always)
                ]
            case .grid:
                cell.screenMode = .grid
            }
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
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchDailyBoxOffices(completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(url: APIs.Kobis.BoxOffice.dailyList.url,
                               requestHeaders: nil,
                               queryParameters: ["key": Environment.kobisApiKey,
                                                 "targetDt": selectedDate.formatted(.iso8601FullDateWithoutSeparator)]) { result in
            switch result {
            case .success(let data):
                do {
                    let responseDTO = try JSONDecoder().decode(DailyBoxOfficeResponseDTO.self, from: data)
                    
                    self.boxOffices = responseDTO.boxOfficeResult.dailyBoxOfficeList.map {
                        $0.toModel()
                    }
                    
                    completion(.success(Void()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @objc private func handleRefreshControl() {
        self.title = selectedDate.formatted(.iso8601FullDate)
        
        collectionView.refreshControl?.beginRefreshing()
        
        self.boxOffices.removeAll()
        self.applySnapshot()
        
        fetchDailyBoxOffices { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.applySnapshot()
                case .failure(let error):
                    self.present(AlertManager.alert(for: error), animated: true)
                }
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc private func presentCalendar() {
        let calendarViewController = CalendarViewController(selectedDate: selectedDate)
        calendarViewController.delegate = self
        self.present(calendarViewController, animated: true)
    }
    
    @objc private func presentLayoutChangeActionSheet() {
        let alertController = UIAlertController(title: "화면모드변경", message: nil, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: screenMode == .list ? "아이콘" : "리스트", style: .default) { _ in
            switch self.screenMode {
            case .list:
                self.screenMode = .grid
            case .grid:
                self.screenMode = .list
            }
            
            self.configureDataSource(to: self.screenMode)
            self.collectionView.setCollectionViewLayout(LayoutManager.layout(screenMode: self.screenMode), animated: false)
            self.applySnapshot()
        }
        
        alertController.addAction(alertAction)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alertController, animated: true)
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dailyBoxOfficeDetailViewController = DailyBoxOfficeDetailViewController(selectedMovieCode: boxOffices[indexPath.row].movieCode, selectedMovieName: boxOffices[indexPath.row].title)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        navigationController?.pushViewController(dailyBoxOfficeDetailViewController, animated: true)
    }
}

extension DailyBoxOfficeViewController: CalendarViewController.Delegate {
    func changeSelectedDate(date: Date) {
        selectedDate = date
        handleRefreshControl()
    }
}
