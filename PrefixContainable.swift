//
//  PrefixContainable.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/7/18.
//

import Foundation

// MARK: - Structure To Handle Prefixes
public protocol PrefixContainable {
    func hasCommonPrefix(with text: String) -> Bool
}

extension ClosedRange: PrefixContainable {
    public func hasCommonPrefix(with text: String) -> Bool {
        guard
            let lower = lowerBound as? String,
            let upper = upperBound as? String
            else {
                return false
        }
        
        let trimmedRange: ClosedRange<String> = {
            let length = text.count
            let trimmedStart = lower.prefix(length)
            let trimmedEnd = upper.prefix(length)
            return trimmedStart...trimmedEnd
        }()
        
        let trimmedText = text.prefix(trimmedRange.lowerBound.count)
        
        return trimmedRange ~= trimmedText
    }
}

extension String: PrefixContainable {
    public func hasCommonPrefix(with text: String) -> Bool {
        return hasPrefix(text) || text.hasPrefix(self)
    }
}

fileprivate extension String {
    func prefix(_ maxLength: Int) -> String {
        return String(prefix(maxLength))
    }
}
