//
//  DailyBoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

class DailyBoxOfficeDetailViewController: UIViewController {    
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
        
        self.title = movieName
        
        fetchDailyBoxOfficeDetail()
        fetchPoster(of: movieName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchDailyBoxOfficeDetail() {
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
                        (self.view as! DailyBoxOfficeDetailView).updateMovieDetailContent(data: movieDetail)
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
    
    private func fetchPoster(of movieName: String) {
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
                    self.present(AlertFactory.alert(for: error), animated: true)
                }
                
                if documents.isEmpty {
                    
                } else {
                    if let document = documents.first,
                       let imageURL = URL(string: document.imageURL) {
                        self.fetchImage(from: imageURL)
                    }
                }
            case .failure(let error):
                self.present(AlertFactory.alert(for: error), animated: true)
            }
        }
    }
    
    private func fetchImage(from url: URL) {
        networkService.request(url: url,
                               requestHeaders: nil,
                               queryParameters: nil) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    (self.view as! DailyBoxOfficeDetailView).updateImageContent(image: UIImage(data: data)!)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
