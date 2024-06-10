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
        navigationBar.topItem?.title = ""
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title2)]
    }

    override open func viewWillLayoutSubviews() {
        NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][\(viewControllers.first == topViewController)][\(viewControllers.count)]")
        // 네비게이션 백버튼
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        guard let vc = topViewController else { return }
        guard let v = vc.view else { return }
        if let p = v.parent(viewType: BackTitleBarView.self) {
            p.Hide()
        }
        if let c = v.child(viewType: BackTitleBarView.self) as? BackTitleBarView {
            // NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][view:\(c)]")
            navigationBar.topItem?.title = c.lb_title.text
            navigationBar.topItem?.titleView?.isHidden = false
        } else {
            navigationBar.topItem?.title = ""
            navigationBar.topItem?.titleView?.isHidden = true
        }
    }
}
