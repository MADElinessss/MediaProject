//
//  TVSeriesInfoTableViewCell.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import UIKit

class TVSeriesInfoTableViewCell: UITableViewCell {
    let tvImageView = UIImageView()
    let tvNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() {
        contentView.addSubview(tvImageView)
        contentView.addSubview(tvNameLabel)
    }

    func configureLayout() {
        tvImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }

        tvNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(tvImageView)
            make.leading.equalTo(tvImageView.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }

        tvNameLabel.textColor = .white
        tvNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        tvNameLabel.numberOfLines = 2
    }
}
