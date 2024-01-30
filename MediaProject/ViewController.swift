////
////  ViewController.swift
////  MediaProject
////
////  Created by Madeline on 2024/01/18.
////
//
//import Alamofire
//import UIKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    // 받아올 데이터
//    var movie: Movie?
//    // 데이터 저장할 리스트
//    var list: [Movie] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureTableView()
//        callRequest("3")
//    }
//    
//    func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    func callRequest(_ personId: String) {
//        let headers: HTTPHeaders = [
//            "Accept": "application/json",
//            "Authorization": "Bearer \(APIKey.TMDBaccessToken)"
//        ]
//        
//        let url = "https://api.themoviedb.org/3/person/\(personId)/movie_credits?language=en-US"
//
//        AF.request(url,
//                   method: .get,
//                   headers: headers)
//        .responseDecodable(of: Movie.self) { response in
//                switch response.result {
//                case .success(let success):
//                    self.movie = success
//                    // TODO: 여기부터해
////                    list.append(movie)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
//}
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
//        
//        let document = list[0].cast[indexPath.row]
//        print(document)
//        cell.titleLabel.text = document.originalTitle
//        
//        return cell
//    }
//}
