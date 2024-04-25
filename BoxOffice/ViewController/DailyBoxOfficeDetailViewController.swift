//
//  DailyBoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

final class DailyBoxOfficeDetailViewController: UIViewController {
    private let networkService = NetworkService()
    private let movieName: String
    private let movieCode: String
    
    init(selectedMovieCode: String, selectedMovieName: String) {
        self.movieName = selectedMovieName
        self.movieCode = selectedMovieCode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = DailyBoxOfficeDetailView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dailyBoxOfficeDetailView = self.view as? DailyBoxOfficeDetailView else {
            return
        }
        
        self.title = movieName
        
        fetchDailyBoxOfficeDetail { result in
            DispatchQueue.main.async {
                dailyBoxOfficeDetailView.dismissActivityIndicator()
                
                switch result {
                case .success(let movieDetail):
                    dailyBoxOfficeDetailView.updateMovieDetailContent(data: movieDetail)
                case .failure(let error):
                    self.present(AlertManager.alert(for: error), animated: true)
                }
            }
        }
        
        fetchPosterURL(of: movieName) { result in
            switch result {
            case .success(let url):
                self.fetchPosterImage(from: url) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            dailyBoxOfficeDetailView.updateImageContent(image: image)
                        case .failure(let error):
                            dailyBoxOfficeDetailView.updateImageContent(image: nil)
                            self.present(AlertManager.alert(for: error), animated: true)
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    dailyBoxOfficeDetailView.updateImageContent(image: nil)
                    self.present(AlertManager.alert(for: error), animated: true)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    private func fetchDailyBoxOfficeDetail(completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        networkService.request(url: APIs.Kobis.Movie.info.url,
                               requestHeaders: nil,
                               queryParameters: ["key": Environment.kobisApiKey,
                                                 "movieCd": movieCode]) { result in
            switch result {
            case .success(let data):
                do {
                    let responseDTO = try JSONDecoder().decode(MovieDetailResponseDTO.self, from: data)
                    let movieDetail = responseDTO.movieInfoResult.movieInfo.toModel()
                    completion(.success(movieDetail))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchPosterURL(of movieName: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        networkService.request(url: APIs.Kakao.Search.image.url,
                               requestHeaders: ["Authorization": "KakaoAK \(Environment.kakaoApiKey)"],
                               queryParameters: ["query": "\(movieName) 영화 포스터",
                                                 "size": "1"]) { result in
            switch result {
            case .success(let data):
                var documents: [Document] = []
                
                do {
                    documents = try JSONDecoder().decode(ImageSearchResponseDTO.self, from: data).documents.map { $0.toModel() }
                } catch {
                    completion(.failure(error))
                }
                
                if let document = documents.first,
                   let imageURL = URL(string: document.imageURL) {
                    completion(.success(imageURL))
                } else {
                    completion(.success(nil))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchPosterImage(from url: URL?, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url else {
            completion(.success(nil))
            return
        }
        
        networkService.request(url: url,
                               requestHeaders: nil,
                               queryParameters: nil) { result in
            switch result {
            case .success(let data):
                completion(.success(UIImage(data: data)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
