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
    
//    let tvImageView = UIImageView()
//    let tvNameLabel = UILabel()
    
    let tableView = UITableView()
    
    var series: TVSeries?
    var recommendationList: [RecommendationResult] = []
    
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
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIManager.shared.fetchTVSeries(self.seriesID) { tvSeries in
                self.series = tvSeries
            }
            group.leave()
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIManager.shared.fetchRecommendation(self.seriesID) { recommendation in
                self.recommendationList = recommendation.results
            }
            group.leave()
        }
        tableView.reloadData()
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func updateUI() {
//        
//    }
//    
    func configureHeirarchy() {
        view.addSubview(backButton)
//        view.addSubview(tvImageView)
//        view.addSubview(tvNameLabel)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(TVSeriesInfoTableViewCell.self, forCellReuseIdentifier: "TVSeriesInfoTableViewCell")
        tableView.register(TVSeriesTableViewCell.self, forCellReuseIdentifier: "TVSeriesTableViewCell")
        tableView.backgroundColor = .black
        
    }
    
    func configureView() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
//        tvImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
//            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
//        }
//        
//        tvNameLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(tvImageView.snp.bottom).inset(24)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
//        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
    }
}

extension TVSeriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            print("***TVSeriesViewController***")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesInfoTableViewCell", for: indexPath) as! TVSeriesInfoTableViewCell
            if let series = self.series {
                let url = URL(string: "https://image.tmdb.org/t/p/w300/\(series.posterPath)")
                cell.tvImageView.kf.setImage(with: url)
                cell.tvNameLabel.text = series.name
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesTableViewCell", for: indexPath) as! TVSeriesTableViewCell
            cell.configure(with: recommendationList)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.5
        } else {
            return UIScreen.main.bounds.height * 0.25
        }
    }
}
