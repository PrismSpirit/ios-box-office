//
//  DailyBoxOfficeDetailViewController.swift
//  BoxOffice
//
//  Created by Prism, Gray on 4/17/24.
//

import UIKit

class DailyBoxOfficeDetailViewController: UIViewController {

    var movieData: MovieDetail {
        MovieDetail(movieName: "쿵푸팬더4", directors: ["마이크 미첼", "스테파니 스티네"], productionYear: 2024, openDate: "20240410", showTime: 93, watchGrade: ["전체관람가"], nations: ["미국"], genres: ["액션","코미디"], actors: ["잭 블랙","아콰피나","비올라 데이비스","더스틴 호프만","제임스 홍","브라이언 크랜스톤","이눈솔"], imageURL: "https://postfiles.pstatic.net/MjAyNDA0MTJfMjEy/MDAxNzEyOTA4MjA4NDE3.2XH0wphgEFhlwrDPulvXmr3RS0i419FwoGAo8U3Mo4Ug.E2CxZqnSyrqOoew4xVI6SHF1JG7eSVWE-52xtSnZtOAg.JPEG/common.jpg?type=w466")
    }
    var networkService = NetworkService()
    var movieName: String
    var movieCode: String
    
    private let scrollView: MovieDetailScrollView = {
        let scrollView = MovieDetailScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = movieName
        
        setupUI()
        self.scrollView.setupUI()
        updateImageView(url: movieData.imageURL)
        self.scrollView.updateMovieDetailContent(data: movieData)
    }
    
    init(selectedMovieCode: String, selectedMovieName: String) {
        self.movieName = selectedMovieName
        self.movieCode = selectedMovieCode
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // 상세영화 API 받아오기
    private func fetchDailyBoxOfficeDetail() {
        networkService.request(url: APIs.Kobis.Movie.info.url, queryParameters: [
            "key": Environment.apiKey,
            "movieCd": movieCode]) { result in
                switch result {
                case .success(let data):
                    do {
                        let responseDTO = try JSONDecoder().decode(MovieDetailResponseDTO.self, from: data)
                        print(responseDTO)
                        
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
    
    func updateImageView(url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] data, response, error in
                    guard let self,
                          let data = data,
                          response != nil,
                          error == nil else { return }
                    DispatchQueue.main.async {
                        self.scrollView.updateImageContent(image: UIImage(data: data) ?? UIImage())
                    }
                }.resume()
    }
    
}
