//
//  TrendCollectionViewCell.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: 순서도 중요함
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView).inset(36)
            make.height.equalTo(44)
            make.width.equalTo(200)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        
        posterImageView.image = UIImage(systemName: "person")
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 20
        
        titleLabel.text = "example"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
