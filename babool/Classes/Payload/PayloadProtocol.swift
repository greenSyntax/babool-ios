//
//  PayloadProtocol.swift
//  babool
//
//  Created by Abhishek Kumar Ravi on 20/07/24.
//

import Foundation

public protocol PayloadProtocol {
    var uuid: String { get set }
    var title: String { get set }
    var description: String { get set }
    var category: String { get set }
    var timestamp: Date { get set }
    
    func getCollumnNamedString() -> String
}
