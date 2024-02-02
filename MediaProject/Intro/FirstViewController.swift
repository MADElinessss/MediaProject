//
//  FirstViewController.swift
//  MediaProject
//
//  Created by Madeline on 2/2/24.
//

import UIKit

class FirstViewController: UIViewController {
    
    let firstIntroImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(firstIntroImageView)
        
        firstIntroImageView.image = UIImage(named: "intro1")
        firstIntroImageView.contentMode = .scaleAspectFit
        
        firstIntroImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(44)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
    }
}
