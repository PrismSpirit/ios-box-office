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
        
        let movieData = MovieDetail(movieName: "쿵푸팬더4", directors: ["마이크 미첼", "스테파니 스티네"], productionYear: 2024, openDate: "20240410", showTime: 93, watchGrade: ["전체관람가"], nations: ["미국"], genres: ["액션","코미디"], actors: ["잭 블랙","아콰피나","비올라 데이비스","더스틴 호프만","제임스 홍","브라이언 크랜스톤","이눈솔"], imageURL: "https://postfiles.pstatic.net/MjAyNDA0MTJfMjEy/MDAxNzEyOTA4MjA4NDE3.2XH0wphgEFhlwrDPulvXmr3RS0i419FwoGAo8U3Mo4Ug.E2CxZqnSyrqOoew4xVI6SHF1JG7eSVWE-52xtSnZtOAg.JPEG/common.jpg?type=w466")
        
        guard let dailyBoxOfficeDetailView = self.view as? DailyBoxOfficeDetailView else {
            return
        }
        
        dailyBoxOfficeDetailView.updateMovieDetailContent(data: movieData)
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
