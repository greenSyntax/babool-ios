//
//  PayloadProtocol.swift
//  babool
//
//  Created by Abhishek Kumar Ravi on 20/07/24.
//

import Foundation

public protocol PayloadProtocol {
    var uuid: String { get set }
    var type: String { get set }
    var title: String { get set }
    var description: String { get set }
    var formattedDate: String { get set }
    var timestamp: Date { get set }
    var client: String { get set }
}
