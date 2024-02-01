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
    
    var series: TVSeries?

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
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }

        tvNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(tvImageView.snp.bottom).inset(16)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black

        tvNameLabel.textColor = .white
        tvNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        tvNameLabel.numberOfLines = 2
        
        tvImageView.clipsToBounds = true
        tvImageView.layer.cornerRadius = 20
        
    }
}

#Preview {
    TVSeriesInfoTableViewCell()
}
