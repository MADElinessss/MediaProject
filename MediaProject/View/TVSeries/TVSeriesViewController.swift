//
//  TVSeriesViewController.swift
//  MediaProject
//
//  Created by Madeline on 1/31/24.
//

import Kingfisher
import SnapKit
import UIKit

class TVSeriesViewController: BaseViewController {
    
    let backButton = UIButton()
    let tableView = UITableView()
    
    var series = TVSeries(backdropPath: "", episodeRunTime: [0], id: 0, name: "", posterPath: "")
    var recommendationList: [RecommendationResult] = []
    var castList: [Actors] = []
    
    var id: Int = 0
    var seriesID: Int = 0
    
    
    init(seriesID: Int) {
        self.seriesID = seriesID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        group.enter()
        APIManager.shared.request(type: TVSeries.self, api: .tvSeries(id: self.seriesID)) { tvSeries in
            self.series = tvSeries
            group.leave()
        }
        
        group.enter()
        APIManager.shared.request(type: Recommendation.self, api: .recommendation(id: self.seriesID)) { recommendation in
            self.recommendationList = recommendation.results
            group.leave()
        }
        
        group.enter()
        APIManager.shared.request(type: Cast.self, api: .cast(id: self.seriesID)) { cast in
            self.castList = cast.crew
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
     
    override func configureHeirarchy() {
        view.addSubview(backButton)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVSeriesInfoTableViewCell.self, forCellReuseIdentifier: "TVSeriesInfoTableViewCell")
        tableView.register(TVSeriesTableViewCell.self, forCellReuseIdentifier: "TVSeriesTableViewCell")
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: "CastTableViewCell")
        tableView.backgroundColor = .black
        
    }
    
    override func configureView() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesInfoTableViewCell", for: indexPath) as! TVSeriesInfoTableViewCell
            let url = URL(string: "https://image.tmdb.org/t/p/w300/\(series.posterPath)")
            
            cell.tvImageView.kf.setImage(with: url)
            cell.tvNameLabel.text = series.name
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            cell.castList = castList
            cell.collectionView.reloadData()
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesTableViewCell", for: indexPath) as! TVSeriesTableViewCell
            cell.onSeriesSelected = { [weak self] seriesID in
                let tvSeriesViewController = TVSeriesViewController(seriesID: seriesID)
                self?.navigationController?.pushViewController(tvSeriesViewController, animated: true)
            }
            
            cell.recommendations = recommendationList
            cell.collectionView.reloadData()
            
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 4, y: 0, width: tableView.bounds.size.width, height: 16)
        headerLabel.textColor = .white
        headerLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        switch section {
        case 0:
            headerLabel.text = ""
        case 1:
            headerLabel.text = "캐스트 정보"
        default:
            headerLabel.text = "추천 콘텐츠"
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
}
