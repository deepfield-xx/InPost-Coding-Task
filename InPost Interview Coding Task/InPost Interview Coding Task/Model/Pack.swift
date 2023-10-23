//
//  Pack.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

/**
 * List of possible statuses with priority order.
 * 1. CREATED
 * 2. CONFIRMED
 * 3. ADOPTED_AT_SOURCE_BRANCH
 * 4. SENT_FROM_SOURCE_BRANCH
 * 5. ADOPTED_AT_SORTING_CENTER
 * 6. SENT_FROM_SORTING_CENTER
 * 7. OTHER
 * 8. DELIVERED
 * 9. RETURNED_TO_SENDER
 * 10. AVIZO
 * 11. OUT_FOR_DELIVERY
 * 12. READY_TO_PICKUP
 * 13. PICKUP_TIME_EXPIRED
 */

enum PackStatus: String, Codable, CaseIterable {
    case created = "CREATED"
    case confirmed = "CONFIRMED"
    case adoptedAtSourceBranch = "ADOPTED_AT_SOURCE_BRANCH"
    case sentFromSourceBranch = "SENT_FROM_SOURCE_BRANCH"
    case adoptedAtSortingCenter = "ADOPTED_AT_SORTING_CENTER"
    case sentFromSortingCenter = "SENT_FROM_SORTING_CENTER"
    case other = "OTHER"
    case delivered = "DELIVERED"
    case returnedToSender = "RETURNED_TO_SENDER"
    case avizo = "AVIZO"
    case outForDelivery = "OUT_FOR_DELIVERY"
    case readyToPickup = "READY_TO_PICKUP"
    case pickupTimeExpired = "PICKUP_TIME_EXPIRED"
    case unknown = "UNKNOWN"
    
    var image: UIImage? {
        switch self {
        case .outForDelivery:
            return UIImage(named: "Kurier")
        case .readyToPickup:
            return UIImage(named: "Paczkomat")
        default:
            return nil
        }
    }
    
    var priority: Int {
        let allCases = PackStatus.allCases
        return allCases.firstIndex(of: self) ?? allCases.count
    }
}

extension PackStatus: UnknownCaseRepresentable {
    static var unknownCase: PackStatus = .unknown
}

struct Pack: Codable {
    let id: String
    let status: PackStatus
    let sender: String
    let expiryDate: Date?
    let pickupDate: Date?
    let storedDate: Date?
    let shipmentType: String
}
