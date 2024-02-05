//
//  MainViewController.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Kingfisher
import SnapKit
import UIKit

class TVMainViewController: BaseViewController {
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var trendingList : [TV] = []
    
    var ratingList : [RatingPopularTV] = [
        RatingPopularTV(results: []),
        RatingPopularTV(results: []),
        RatingPopularTV(results: [])
    ]
    
    var popularList : [RatingPopularTV] = [
        RatingPopularTV(results: []),
        RatingPopularTV(results: []),
        RatingPopularTV(results: [])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APISessionManager.shared.fetchTV(type: TrendingTV.self, api: .trending, url: TMDBAPI.trending.endPoint) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.trendingList = tv.results
                self.collectionView.reloadData()
            }
        }

        APISessionManager.shared.fetchTV(type: RatingPopularTV.self, api: .rating, url: TMDBAPI.rating.endPoint) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.ratingList[0] = tv
                self.tableView.reloadData()
            }
        }

        APISessionManager.shared.fetchTV(type: RatingPopularTV.self, api: .popular, url: TMDBAPI.popular.endPoint) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.popularList[0] = tv
                self.tableView.reloadData()
            }
        }
    }
    
    override func configureHeirarchy() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        
        logoImageView.image = UIImage(named: "logo")
        
        titleLabel.text = "새싹티비"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(named: "pointColor")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")
        tableView.backgroundColor = .black
        
    }
    
    override func configureView() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

extension TVMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: "RatingCollectionViewCell")
        cell.collectionView.tag = indexPath.section
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 4, y: 0, width: tableView.bounds.size.width, height: 16)
        headerLabel.textColor = .white
        headerLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        switch section {
        case 0:
            headerLabel.text = "TOP 랭킹"
        case 1:
            headerLabel.text = "인기 작품"
        default:
            headerLabel.text = ""
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
}

extension TVMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return trendingList.count
        } else {
            switch collectionView.tag {
            case 0:
                return ratingList[0].results.count
            case 1:
                return popularList[0].results.count
            default:
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCollectionViewCell", for: indexPath) as! TrendCollectionViewCell
                    cell.titleLabel.text = trendingList[indexPath.item].name
                    let url = URL(string: "https://image.tmdb.org/t/p/w300/\(trendingList[indexPath.item].posterPath)")
                    cell.posterImageView.kf.setImage(with: url)
                    return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingCollectionViewCell", for: indexPath) as! RatingCollectionViewCell
            
            if collectionView.tag == 0 {
                let result = ratingList[0].results[indexPath.item]
                if let posterPath = result.posterPath {
                    let url = URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath)")
                    cell.posterImageView.kf.setImage(with: url)
                } else {
                    cell.posterImageView.image = UIImage(named: "default")
                }
                
            } else if collectionView.tag == 1 {
                let result = popularList[0].results[indexPath.item]
                
                if let posterPath = result.posterPath {
                    let url = URL(string: "https://image.tmdb.org/t/p/w300/\(posterPath)")
                    cell.posterImageView.kf.setImage(with: url)
                } else {
                    cell.posterImageView.image = UIImage(named: "default")
                }
                
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seriesID: Int
        
        if collectionView == self.collectionView {
            seriesID = trendingList[indexPath.item].id
        } else if collectionView.tag == 0 {
            seriesID = ratingList[0].results[indexPath.item].id
        } else {
            seriesID = popularList[0].results[indexPath.item].id
        }
        
        let tvSeriesViewController = TVSeriesViewController(seriesID: seriesID)
        tvSeriesViewController.modalPresentationStyle = .fullScreen
        present(tvSeriesViewController, animated: true)
    }
}
