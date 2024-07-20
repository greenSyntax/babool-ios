//
//  DefaultPayload.swift
//  babool
//
//  Created by Abhishek Kumar Ravi on 20/07/24.
//

import Foundation

public struct DefaultPayload: PayloadProtocol {
    public var uuid: String
    public var title: String
    public var description: String
    public var category: String
    public var timestamp: Date
    
    public init(title: String, description: String, category: String) {
        self.uuid = UUID().uuidString
        self.title = title
        self.description = description
        self.category = category
        self.timestamp = Date()
    }
    
    public func getCollumnNamedString() -> String {
        return "\("UID"),\("Title"),\("Description"),\("Category"),\("Timestamp")\n\n"
    }
}
