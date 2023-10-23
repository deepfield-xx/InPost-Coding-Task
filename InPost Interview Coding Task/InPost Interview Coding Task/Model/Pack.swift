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

typealias OrderPredicate = (Pack, Pack) -> Bool
extension Array where Element == Pack {
    func sortPacks() -> [Pack] {
        return sorted { lhs, rhs in
            let predicates: [OrderPredicate] = [
                { $0.status.priority > $1.status.priority },
                {
                    guard let pickupDate1 = $0.pickupDate, let pickupDate2 = $1.pickupDate else {
                        return false
                    }
                    
                    return pickupDate1 < pickupDate2
                },
                {
                    guard let expiryDate1 = $0.expiryDate, let expiryDate2 = $1.expiryDate else {
                        return false
                    }
                
                    return expiryDate1 < expiryDate2
                },
                {
                    guard let storedDate1 = $0.storedDate, let storedDate2 = $1.storedDate else {
                        return false
                    }
                    
                    return storedDate1 < storedDate2
                },
                { $0.id < $1.id }
            ]
            
            for predicate in predicates {
                if !predicate(lhs, rhs) && !predicate(rhs, lhs) {
                    continue
                }
                
                return predicate(lhs, rhs)
            }
            
            return false
        }
    }
}
