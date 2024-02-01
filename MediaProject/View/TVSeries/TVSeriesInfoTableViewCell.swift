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
        configureView()
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
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(300)
//            make.width.equalTo(150)
        }

        tvNameLabel.snp.makeConstraints { make in
            //            make.centerY.equalTo(tvImageView)
            make.bottom.equalTo(tvImageView.snp.bottom).inset(16)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    func configureView() {
        
        print("###TVSeriesInfoTableViewCell###")
        contentView.backgroundColor = .black
        
        tvImageView.image = UIImage(systemName: "person")
        
        tvNameLabel.text = "NAME"
        tvNameLabel.textColor = .white
        tvNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        tvNameLabel.numberOfLines = 2
    }
}

#Preview {
    TVSeriesInfoTableViewCell()
}
