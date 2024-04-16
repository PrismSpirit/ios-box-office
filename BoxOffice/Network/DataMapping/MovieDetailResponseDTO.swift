//
//  MovieDetailResponseDTO.swift
//  BoxOffice
//
//  Created by Jaehun Lee on 4/5/24.
//

struct MovieDetailResponseDTO: Decodable {
    let movieInfoResult: MovieInfoResultDTO
}

extension MovieDetailResponseDTO {
    struct MovieInfoResultDTO: Decodable {
        let movieInfo: MovieInfoDTO
        let source: String
    }
}

extension MovieDetailResponseDTO {
    struct MovieInfoDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case movieName = "movieNm"
            case directors
            case productionYear = "prdtYear"
            case openDate = "openDt"
            case showTime = "showTm"
            case audits
            case nations
            case genres
            case actors
        }
        
        let movieName: String
        let directors: [DirectorDTO]
        let productionYear: String
        let openDate: String
        let showTime: String
        let audits: [AuditDTO]
        let nations: [NationDTO]
        let genres: [GenreDTO]
        let actors: [ActorDTO]
    }
}

extension MovieDetailResponseDTO {
    struct DirectorDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case name = "peopleNm"
            case nameEN = "peopleNmEn"
        }
        
        let name: String
        let nameEN: String
    }
    
    struct AuditDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case auditNumber = "auditNo"
            case watchGradeName = "watchGradeNm"
        }
        
        let auditNumber: String
        let watchGradeName: String
    }
    
    struct NationDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case nationName = "nationNm"
        }
        
        let nationName: String
    }
    
    struct GenreDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case genreName = "genreNm"
        }
        
        let genreName: String
    }
    
    struct ActorDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case actorName = "peopleNm"
            case actorNameEN = "peopleNmEn"
            case castName = "cast"
            case castNameEN = "castEn"
        }
        
        let actorName: String
        let actorNameEN: String
        let castName: String
        let castNameEN: String
    }
}

