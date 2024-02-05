//
//  CastCollectionViewCell.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import SnapKit
import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    let profileImage = UIImageView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePosterImageView()
        
        contentView.addSubview(profileImage)
        contentView.addSubview(name)
        
        profileImage.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView).inset(32)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(16)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
    }
    
    private func configurePosterImageView() {
        profileImage.layer.cornerRadius = 13
        profileImage.clipsToBounds = true
        
        name.font = .systemFont(ofSize: 14, weight: .medium)
        name.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
