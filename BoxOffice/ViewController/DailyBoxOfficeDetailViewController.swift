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
        
        Task {
            do {
                let movieDetail = try await fetchDailyBoxOfficeDetail()
                dailyBoxOfficeDetailView.updateMovieDetailContent(data: movieDetail)
            } catch {
                self.present(AlertManager.alert(for: error), animated: true)
            }
            dailyBoxOfficeDetailView.dismissActivityIndicator()
        }
        
        Task {
            do {
                let image = try await fetchPosterImage(from: fetchPosterURL(of: movieName))
                dailyBoxOfficeDetailView.updateImageContent(image: image)
            } catch {
                dailyBoxOfficeDetailView.updateImageContent(image: nil)
                self.present(AlertManager.alert(for: error), animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    private func fetchDailyBoxOfficeDetail() async throws -> MovieDetail {
        let data = try await networkService.request(url: APIs.Kobis.Movie.info.url,
                                                    requestHeaders: nil,
                                                    queryParameters: ["key": Environment.kobisApiKey,
                                                                      "movieCd": movieCode])
        
        let responseDTO = try JSONDecoder().decode(MovieDetailResponseDTO.self, from: data)
        
        return responseDTO.movieInfoResult.movieInfo.toModel()
    }
    
    private func fetchPosterURL(of movieName: String) async throws -> URL? {
        let data = try await networkService.request(url: APIs.Kakao.Search.image.url,
                                                    requestHeaders: ["Authorization": "KakaoAK \(Environment.kakaoApiKey)"],
                                                    queryParameters: ["query": "\(movieName) 영화 포스터",
                                                                      "size": "1"])
        
        let documents = try JSONDecoder().decode(ImageSearchResponseDTO.self, from: data).documents.map { $0.toModel() }
        
        guard let document = documents.first,
              let url = URL(string: document.imageURL) else {
            return nil
        }
        
        return url
    }
    
    private func fetchPosterImage(from url: URL?) async throws -> UIImage? {
        guard let url else {
            return nil
        }
        
        let data = try await networkService.request(url: url,
                                                    requestHeaders: nil,
                                                    queryParameters: nil)
        
        return UIImage(data: data)
    }
}
