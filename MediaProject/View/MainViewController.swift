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
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
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
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
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
    
    func configureView() {
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: "RatingCollectionViewCell")
            cell.collectionView.tag = indexPath.section
        case 1:
            print("3")
        default:
            break
        }
        
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
            headerLabel.text = "다른 제목"
        default:
            headerLabel.text = ""
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return trendingList.count
        } else {
            return ratingList[collectionView.tag].results.count
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
            let result = ratingList[collectionView.tag].results[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(result.posterPath)")
            cell.posterImageView.kf.setImage(with: url)
            return cell
        }
    }
}
