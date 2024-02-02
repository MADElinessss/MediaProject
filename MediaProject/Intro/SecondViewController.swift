//
//  SecondViewController.swift
//  MediaProject
//
//  Created by Madeline on 2/2/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    let startButton = UIButton()
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(startButton)
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(24)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 20
        
        logoImageView.image = UIImage(named: "logo")
        
        titleLabel.text = "새싹티비"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(named: "pointColor")
    }
    
    @objc func startButtonTapped() {
        let vc = TVMainViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vc, animated: true)
        } else {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

