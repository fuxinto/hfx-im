//
//  FXDecimalNumbereE.swift
//  LoanSupermarket
//
//  Created by 黄福鑫 on 2022/2/10.
//

import Foundation

extension NSDecimalNumber {
    static func + (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.adding(rhs)
    }
    static func - (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.subtracting(rhs)
    }
    
    static func * (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.multiplying(by: rhs)
    }
    
    static func / (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.dividing(by: rhs)
    }
}

