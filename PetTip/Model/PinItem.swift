//
//  PinItem.swift
//  PetTip
//
//  Created by isyuun on 2024/5/30.
//

import Foundation
import MapKit

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
