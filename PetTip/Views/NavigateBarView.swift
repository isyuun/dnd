//
//  NavigationBarView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/5.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        navigationBar.topItem?.title = ""
        navigationBar.topItem?.titleView?.isHidden = true
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
