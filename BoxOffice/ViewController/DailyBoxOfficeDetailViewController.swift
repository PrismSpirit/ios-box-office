//
//  DailyBoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

final class DailyBoxOfficeDetailViewController: UIViewController {
    var networkService = NetworkService()
    var movieName: String
    var movieCode: String
    
    init(selectedMovieCode: String, selectedMovieName: String) {
        self.movieName = selectedMovieName
        self.movieCode = selectedMovieCode
        super.init(nibName: nil, bundle: nil)
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
        
        fetchDailyBoxOfficeDetail(view: dailyBoxOfficeDetailView) {
            DispatchQueue.main.async {
                dailyBoxOfficeDetailView.dismissActivityIndicator()
            }
        }
        
        fetchPoster(of: movieName, view: dailyBoxOfficeDetailView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchDailyBoxOfficeDetail(view: DailyBoxOfficeDetailView, completion: @escaping () -> Void) {
        networkService.request(url: APIs.Kobis.Movie.info.url,
                               requestHeaders: nil,
                               queryParameters: ["key": Environment.kobisApiKey,
                                                 "movieCd": movieCode]) { result in
            switch result {
            case .success(let data):
                do {
                    let responseDTO = try JSONDecoder().decode(MovieDetailResponseDTO.self, from: data)
                    
                    let movieDetail = responseDTO.movieInfoResult.movieInfo.toModel()
                    
                    DispatchQueue.main.async {
                        view.updateMovieDetailContent(data: movieDetail)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.present(AlertManager.alert(for: error), animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(AlertManager.alert(for: error), animated: true)
                }
            }
            completion()
        }
    }
    
    private func fetchPoster(of movieName: String, view: DailyBoxOfficeDetailView) {
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
                    DispatchQueue.main.async {
                        self.present(AlertManager.alert(for: error), animated: true)
                    }
                }
                
                if let document = documents.first,
                   let imageURL = URL(string: document.imageURL) {
                    self.fetchImage(view: view, from: imageURL)
                } else {
                    DispatchQueue.main.async {
                        view.updateImageContent(image: nil)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(AlertManager.alert(for: error), animated: true)
                    view.updateImageContent(image: nil)
                }
            }
        }
    }
    
    private func fetchImage(view: DailyBoxOfficeDetailView, from url: URL) {
        networkService.request(url: url,
                               requestHeaders: nil,
                               queryParameters: nil) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    view.updateImageContent(image: UIImage(data: data))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(AlertManager.alert(for: error), animated: true)
                    view.updateImageContent(image: nil)
                }
            }
        }
    }
}
