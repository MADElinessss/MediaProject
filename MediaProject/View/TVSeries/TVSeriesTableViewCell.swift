//
//  TVSeriesTableViewCell.swift
//  MediaProject
//
//  Created by Madeline on 1/31/24.
//

import Kingfisher
import UIKit

class TVSeriesTableViewCell: UITableViewCell {
    
    weak var delegate: TVSeriesTableViewCellDelegate?
//    var onSeriesSelected: ((Int) -> Void)?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionLayout())
    var recommendations: [RecommendationResult] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

    func configureView() {
        collectionView.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVSeriesCollectionViewCell.self, forCellWithReuseIdentifier: "TVSeriesCollectionViewCell")
        collectionView.reloadData()
    }
    
    static func configureCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}

extension TVSeriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSeriesCollectionViewCell", for: indexPath) as! TVSeriesCollectionViewCell
    
        let recommendation = recommendations[indexPath.item]
        if let url = recommendation.posterPath {
            let fullUrl = URL(string: "https://image.tmdb.org/t/p/w300/\(url)")
            cell.posterImageView.kf.setImage(with: fullUrl)
        } else {
            cell.posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let seriesID: Int
        seriesID = recommendations[indexPath.item].id

        delegate?.didSelectSeries(withID: seriesID)
        
    }
}
