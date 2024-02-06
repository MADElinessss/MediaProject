//
//  TVSeriesInfoTableViewCell.swift
//  MediaProject
//
//  Created by Madeline on 2/1/24.
//

import UIKit

class TVSeriesInfoTableViewCell: UITableViewCell {
    let tvImageView = UIImageView()
    let playButton = UIButton()
    let tvPosterView = UIImageView()
    let tvNameLabel = UILabel()
    let overView = UILabel()
    let isAdult = UILabel()
    let shareButton = UIButton()
    let addButton = UIButton()
    
    var adult : Bool = false
    
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
        contentView.addSubview(playButton)
        contentView.addSubview(tvPosterView)
        contentView.addSubview(tvNameLabel)
        contentView.addSubview(overView)
        contentView.addSubview(isAdult)
        contentView.addSubview(addButton)
        contentView.addSubview(shareButton)
    }

    func configureLayout() {
        tvImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.3)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(tvImageView)
//            make.top.equalTo(tvImageView.snp.top).inset(UIScreen.main.bounds.height * 0.15)
            make.width.height.equalTo(200)
        }
        
        tvNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tvImageView.snp.bottom).inset(-16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(UIScreen.main.bounds.width * 0.5)
        }
        
        tvPosterView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.top.equalTo(tvNameLabel.snp.top)
            make.height.equalTo(80)
        }

        isAdult.snp.makeConstraints { make in
            make.top.equalTo(tvNameLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(isAdult.snp.bottom).inset(-8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(isAdult.snp.bottom).inset(-8)
            make.leading.equalTo(addButton.snp.trailing).offset(16)
        }
        
        overView.snp.makeConstraints { make in
            make.top.equalTo(shareButton.snp.bottom).inset(-8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }

    }
    
    func configureView() {
        contentView.backgroundColor = .black

        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.contentMode = .scaleToFill
        playButton.tintColor = .white
        
        
        tvNameLabel.textColor = .white
        tvNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        tvNameLabel.numberOfLines = 0
        
        tvImageView.clipsToBounds = true
        tvImageView.contentMode = .scaleAspectFit
        
        tvPosterView.clipsToBounds = true
        tvPosterView.contentMode = .scaleAspectFit
        tvPosterView.layer.cornerRadius = 15
        
        overView.textColor = .white
        overView.font = .systemFont(ofSize: 14, weight: .medium)
        overView.numberOfLines = 5
        
        isAdult.text = adult ? "18+" : "15+"
        isAdult.font = .systemFont(ofSize: 14, weight: .medium)
        isAdult.textColor = .white
        
        var addButtonConfig = configurationButton(withTitle: "찜한 콘텐츠", systemImageName: "plus")
        addButton.configuration = addButtonConfig
        addButton.tintColor = .white
        
        var shareButtonConfig = configurationButton(withTitle: "공유", systemImageName: "square.and.arrow.up")
        shareButton.configuration = shareButtonConfig
        shareButton.tintColor = .white
    }
}

extension TVSeriesInfoTableViewCell {
    func configurationButton(withTitle title: String, systemImageName imageName: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = UIImage(systemName: imageName)
        config.imagePlacement = .top
        config.imagePadding = 4
        config.baseForegroundColor = .white
        return config
    }
}
