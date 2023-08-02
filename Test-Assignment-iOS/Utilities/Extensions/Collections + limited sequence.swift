//
//  Collections + limited sequence.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 03.08.2023.
//

import Foundation

//MARK: - Collection + some amount sequence limitation
extension Collection {
    
    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < endIndex else { return nil }
            let end = index(start, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { let _ = formIndex(&index, offsetBy: n, limitedBy: endIndex) }
            return self[index]
        }
    }

}
