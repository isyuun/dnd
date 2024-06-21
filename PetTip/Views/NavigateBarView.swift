//
//  NavigationBarView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/5.
//

import UIKit

extension UINavigationController: UINavigationControllerDelegate {
    override open func viewDidLoad() {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(viewControllers.count)][\(viewControllers)]")
        super.viewDidLoad()
        navigationController?.delegate = self
        // 네비게이션 백버튼
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        // 네비게이션 타이틀
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)]

        // 네비게이션 바 타이틀에 시스템 폰트 적용
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationBar.titleTextAttributes = attributes
    }

    override open func viewWillLayoutSubviews() {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(viewControllers.first == topViewController)][\(viewControllers.count)]")
        super.viewWillLayoutSubviews()
        // 네비게이션 백버튼
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        // 네비게이션 타이틀
        // if viewControllers.first == topViewController {
        //     // navigationBar.topItem?.title = navigationBar.topItem?.title
        //     // navigationBar.topItem?.titleView?.isHidden = true
        // }
        guard let v = topViewController?.view else { return }
        if let p = v.parent(viewType: BackTitleBarView.self) {
            p.Hide()
        }
        // if let c = v.child(viewType: BackTitleBarView.self) as? BackTitleBarView {
        //     navigationBar.topItem?.title = c.lb_title.text
        //     navigationBar.topItem?.titleView?.isHidden = false
        // }
    }
}
