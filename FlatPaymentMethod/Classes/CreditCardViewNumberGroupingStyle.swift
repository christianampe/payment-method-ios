//
//  CreditCardViewNumberGroupingStyle.swift
//  FlatCreditCard
//
//  Created by Ampe on 8/13/18.
//

import Foundation

public enum CreditCardViewNumberGroupingStyle {
    case none
    case custom(grouping: [Int], separator: String, addRemainderSection: Bool)
}

public extension CreditCardViewNumberGroupingStyle {
    public static let `default`: CreditCardViewNumberGroupingStyle = .custom(grouping: [4, 4, 4, 4],
                                                                             separator: "   ",
                                                                             addRemainderSection: false)
}

public extension CreditCardViewNumberGroupingStyle {
    public func groupedText(for input: String) -> String {
        switch self {
        case .none:
            return input
        case .custom(let grouping, let separator, let shouldAddRemainderSection):
            var input: String = input
            var output: String.SubSequence = ""
            
            for (index, group) in grouping.enumerated() {
                guard !input.isEmpty else {
                    break
                }
                
                guard input.count >= group else {
                    output.append(contentsOf: input)
                    return String(output)
                }
                
                output.append(contentsOf: input.prefix(group))
                
                if index < grouping.count - 1 {
                    output.append(contentsOf: separator)
                }
                
                input.removeFirst(group)
            }
            
            switch shouldAddRemainderSection {
            case true:
                output.append(contentsOf: separator)
                output.append(contentsOf: input)
            case false:
                output.append(contentsOf: input)
            }
            
            return String(output)
        }
    }
}
