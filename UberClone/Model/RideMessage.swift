//
//  RideMessage.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 07/10/25.
//

import Foundation

struct RideMessage: Identifiable {
    let id = UUID()
    let title: String
    let body: String
    let date: String
    let icon: String
}
