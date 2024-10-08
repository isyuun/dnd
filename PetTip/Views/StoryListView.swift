//
//  StoryListView.swift
//  PetTip
//
//  Created by isyuun on 2024/5/31.
//

import SwiftUI

struct StoryListView: View {
    var body: some View {
        StoryListViewCtrl()
    }
}

struct StoryListViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> StoryListViewController2 {
        let viewController = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(identifier: "StoryListViewController") as! StoryListViewController2
        return viewController
    }

    func updateUIViewController(_ uiViewController: StoryListViewController2, context: Context) {}
}


#Preview {
    StoryListView()
}
