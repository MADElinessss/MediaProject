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
            make.horizontalEdges.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(24)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(4)
            make.height.equalTo(20)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        print("CastCollectionViewCell init")
    }
    
    private func configurePosterImageView() {
        profileImage.layer.cornerRadius = 20
        profileImage.clipsToBounds = true
        
        name.font = .systemFont(ofSize: 16, weight: .medium)
        name.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
