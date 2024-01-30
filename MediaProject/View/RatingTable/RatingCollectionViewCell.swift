//
//  RatingCollectionViewCell.swift
//  MediaProject
//
//  Created by Madeline on 1/30/24.
//

import SnapKit
import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
