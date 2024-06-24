//
//  EventView.swift
//  PetTip
//
//  Created by isyuun on 2024/6/24.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        EventViewCtrl()
            .navigationTitle("이벤트")
    }
}

struct EventViewCtrl: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> EventListViewController2 {
        return UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "EventListViewController") as! EventListViewController2
    }

    func updateUIViewController(_ uiViewController: EventListViewController2, context: Context) {}
}

#Preview {
    EventView()
}
