//
//  TVSeriesTableViewCell.swift
//  MediaProject
//
//  Created by Madeline on 1/31/24.
//

import UIKit

class TVSeriesTableViewCell: UITableViewCell {
    
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

extension TVSeriesTableViewCell {
    func configure(with recommendations: [RecommendationResult]) {
        // 컬렉션 뷰 대리자 및 데이터 소스 설정
        collectionView.delegate = self
        collectionView.dataSource = self

        // 컬렉션 뷰에 데이터 전달
        collectionView.reloadData()
    }
}

extension TVSeriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSeriesCollectionViewCell", for: indexPath) as! TVSeriesCollectionViewCell
        let recommendation = recommendations[indexPath.item]
        let url = URL(string: "https://image.tmdb.org/t/p/w300/\(recommendation.posterPath)")
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
}
