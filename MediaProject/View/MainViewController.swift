//
//  MainViewController.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import Kingfisher
import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var trendingList : [TV] = []
    var ratingList : [RatingTV] = [
        RatingTV(results: []),
        RatingTV(results: []),
        RatingTV(results: [])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHeirarchy()
        configureLayout()
        configureView()
        setBackgroundColor()
        
        APIManager.shared.fetchTrendingTV { tv in
            self.trendingList = tv
            self.collectionView.reloadData()
        }
        
        APIManager.shared.fetchTopRatedTV { tv in
            self.ratingList[0] = tv
            self.tableView.reloadData()
        }
    }
    
    func configureHeirarchy() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: "TrendCollectionViewCell")
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(RatingTableViewCell.self, forCellReuseIdentifier: "RatingTableViewCell")

        
    }
    
    func configureView() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(RatingTableViewCell.self, forCellWithReuseIdentifier: "RatingTableViewCell")
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.collectionView == collectionView {
            return trendingList.count
        } else {
            return ratingList[collectionView.tag].results.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.collectionView == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendCollectionViewCell", for: indexPath) as! TrendCollectionViewCell
            
            cell.titleLabel.text = trendingList[indexPath.item].name
            
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(trendingList[indexPath.item].posterPath)")
            cell.posterImageView.kf.setImage(with: url)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingCollectionViewCell", for: indexPath) as! RatingCollectionViewCell
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(ratingList[collectionView.tag].results[indexPath.item])")
            cell.posterImageView.kf.setImage(with: url)
            
            return cell
        }
    }
}
