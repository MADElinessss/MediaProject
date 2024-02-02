//
//  WalkThroughViewController.swift
//  MediaProject
//
//  Created by Madeline on 2/2/24.
//

import SnapKit
import UIKit

class WalkThroughViewController: UIPageViewController {
    var pageViewControllerList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createPageViewController()
        configurePageViewController()
        
    }
    
    // 뷰 컨트롤러 배열 만드는 메서드
    func createPageViewController() {
        let vc1 = FirstViewController()
        let vc2 = SecondViewController()
        
        pageViewControllerList = [vc1, vc2]
    }
    
    func configurePageViewController() {
        self.delegate = self
        self.dataSource = self
        
        // 실행하자마자 몇번째 페이지 보여주실 -> Display
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
}

extension WalkThroughViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 이전 화면 구성
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 지금 화면 뭔데? -> 현재 pageVC에 보이는 VC의 인데스를 가져온다
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    // 이후 화면 구성
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    // 스타일 - 동그라미 개수, 첫번째 보여줄 인덱스
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
                let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        return index
    }
}
