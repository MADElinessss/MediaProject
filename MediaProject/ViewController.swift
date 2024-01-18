//
//  ViewController.swift
//  MediaProject
//
//  Created by Madeline on 2024/01/18.
//

import Alamofire
import UIKit

// MARK: - Movie
struct Movie: Codable {
    let cast, crew: [Cast]
    let id: Int
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let character: String?
    let creditID: String
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // 받아올 데이터
    var movie: Movie?
    // 데이터 저장할 리스트
    var list: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        callRequest("3")
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func callRequest(_ personId: String) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(APIKey.TMDBaccessToken)"
        ]
        
        let url = "https://api.themoviedb.org/3/person/\(personId)/movie_credits?language=en-US"

        AF.request(url,
                   method: .get,
                   headers: headers)
        .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let success):
                    self.movie = success
                    // TODO: 여기부터해
//                    list.append(movie)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        let document = list[0].cast[indexPath.row]
        print(document)
        cell.titleLabel.text = document.originalTitle
        
        return cell
    }
}
