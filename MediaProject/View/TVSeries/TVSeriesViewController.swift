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
    
    var series = TVSeries(adult: false, backdropPath: "", episodeRunTime: [0], id: 0, name: "", overview: "", posterPath: "")
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
        APISessionManager.shared.fetchTV(type: TVSeries.self, api: .tvSeries(id: seriesID), url: TMDBAPI.tvSeries(id: seriesID).endPoint) { tv, error in
            if error == nil {
                guard let tvSeries = tv else { return }
                self.series = tvSeries
            } else {
                
            }
            group.leave()
        }
        
        group.enter()
        APISessionManager.shared.fetchTV(type: Recommendation.self, api: .recommendation(id: seriesID), url: TMDBAPI.recommendation(id: seriesID).endPoint) { tv, error in
            if error == nil {
                guard let recommendation = tv else { return }
                self.recommendationList = recommendation.results
            } else {
                
            }
            group.leave()
        }
        
        group.enter()
        APISessionManager.shared.fetchTV(type: Cast.self, api: .cast(id: seriesID), url: TMDBAPI.cast(id: seriesID).endPoint) { tv, error in
            if error == nil {
                guard let cast = tv else { return }
                self.castList = cast.crew
            } else {
                
            }
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
            make.top.equalTo(backButton.snp.bottom)
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
            if let url = series.backdropPath {
                let fullUrl = URL(string: "https://image.tmdb.org/t/p/w300/\(url)")
                cell.tvImageView.kf.setImage(with: fullUrl)
            } else {
                cell.tvImageView.image = UIImage(systemName: "movieclapper")
            }
            
            if let url = series.posterPath {
                let fullUrl = URL(string: "https://image.tmdb.org/t/p/w300/\(url)")
                cell.tvPosterView.kf.setImage(with: fullUrl)
            } else {
                cell.tvPosterView.image = UIImage(systemName: "movieclapper")
            }
            
            cell.tvNameLabel.text = series.name
            cell.overView.text = series.overview
            cell.adult = series.adult
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            cell.castList = castList
            cell.collectionView.reloadData()
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesTableViewCell", for: indexPath) as! TVSeriesTableViewCell

            cell.delegate = self
            cell.recommendations = recommendationList
            cell.collectionView.reloadData()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.6
        } else if indexPath.section == 1 {
            return UIScreen.main.bounds.height * 0.1
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

extension TVSeriesViewController: TVSeriesTableViewCellDelegate {
    func didSelectSeries(withID seriesID: Int) {
        let tvSeriesViewController = TVSeriesViewController(seriesID: seriesID)
        tvSeriesViewController.modalPresentationStyle = .fullScreen
        present(tvSeriesViewController, animated: true)
    }
}
