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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func fetchDailyBoxOfficeDetail() {
        networkService.request(url: APIs.Kobis.Movie.info.url,
                               queryParameters: ["key": Environment.apiKey,
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
}
