//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by Madeline on 1/31/24.
//

import Kingfisher
import SnapKit
import UIKit

class TVSeriesViewController: UIViewController {
    
    let backButton = UIButton()
    
    let tvImageView = UIImageView()
    let tvNameLabel = UILabel()
    
    let tableView = UITableView()
    
    var series: TVSeries?
    
    var id: Int = 0
    
    var seriesID: Int
    
    init(seriesID: Int) {
        self.seriesID = seriesID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHeirarchy()
        configureLayout()
        configureView()
        setBackgroundColor()
        
        let group = DispatchGroup()
        
        APIManager.shared.fetchTVSeries(seriesID) { tvSeries in
            DispatchQueue.main.async {
                self.series = tvSeries
                self.updateUI()
            }
        }
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        if let series = self.series {
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(series.posterPath)")
            tvImageView.kf.setImage(with: url)
            tvImageView.layer.cornerRadius = 20
            tvImageView.clipsToBounds = true
            tvNameLabel.text = series.name
            tvNameLabel.textColor = .white
            tvNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
            tvNameLabel.numberOfLines = 2
        }
    }
    
    func configureHeirarchy() {
        view.addSubview(backButton)
        view.addSubview(tvImageView)
        view.addSubview(tvNameLabel)
        //        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        //        backButton.setTitle("Back", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        tableView.rowHeight = 150
        //        tableView.register(TVSeriesTableViewCell.self, forCellReuseIdentifier: "TVSeriesTableViewCell")
        //        tableView.backgroundColor = .black
        
    }
    
    func configureView() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        tvImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        
        tvNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tvImageView.snp.bottom).inset(24)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        
        //        tableView.snp.makeConstraints { make in
        //            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        //            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        //            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        //        }
    }
}

extension TVSeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesInfoTableViewCell", for: indexPath) as! TVSeriesInfoTableViewCell
            if let series = self.series {
                let url = URL(string: "https://image.tmdb.org/t/p/w300/\(series.posterPath)")
                cell.tvImageView.kf.setImage(with: url)
                cell.tvNameLabel.text = series.name
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesTableViewCell", for: indexPath) as! TVSeriesTableViewCell
            // 컬렉션 뷰 구성 코드
            return cell
        }
    }
}


//extension TVSeriesViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesTableViewCell", for: indexPath) as! TVSeriesTableViewCell
//
//        cell.collectionView.delegate = self
//        cell.collectionView.dataSource = self
//        cell.collectionView.register(TVSeriesCollectionViewCell.self, forCellWithReuseIdentifier: "TVSeriesCollectionViewCell")
//        cell.collectionView.tag = indexPath.section
//
//        cell.collectionView.reloadData()
//
//        return cell
//    }
//
//}
//
//extension TVSeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1 // 항상 1을 반환
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSeriesCollectionViewCell", for: indexPath) as! TVSeriesCollectionViewCell
//
//        // series를 사용하여 셀 구성
//        if let series = self.series {
//            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(series.posterPath)")
//            cell.posterImageView.kf.setImage(with: url)
//        }
//
//        return cell
//    }
//}
