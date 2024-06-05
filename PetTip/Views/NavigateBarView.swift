//
//  NavigationBarView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/5.
//

import UIKit

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        // NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)]")
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        // 네비게이션 타이틀
        navigationBar.topItem?.title = "타이틀"
        guard let vc = topViewController else { return }
        guard let v = vc.view else { return }
        if let p = v.parent(viewType: BackTitleBarView.self) {
            p.Hide()
        }
        if let c = v.child(viewType: BackTitleBarView.self) as? BackTitleBarView {
            NSLog("[LOG][I][(\(#fileID):\(#line))::\(#function)][view:\(c)]")
            navigationBar.topItem?.title = c.lb_title.text
            navigationBar.topItem?.titleView?.isHidden = false
        } else {
            navigationBar.topItem?.title = ""
            navigationBar.topItem?.titleView?.isHidden = true
        }
    }
}
