//
//  Array+Extension.swift
//  DisplayGrid
//
//  Created by Tianyi and Jack on 23/7/22.
//   
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
