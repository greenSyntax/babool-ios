//
//  DefaultPayload.swift
//  babool
//
//  Created by Abhishek Kumar Ravi on 20/07/24.
//

import Foundation

public struct DefaultPayload: PayloadProtocol {
    public var uuid: String
    public var type: String
    public var formattedDate: String
    public var client: String
    public var title: String
    public var description: String
    public var timestamp: Date
    
    public init(type: String, title: String, description: String, formattedDate: String, client: String) {
        self.uuid = UUID().uuidString
        self.type = type
        self.title = title
        self.description = description
        self.timestamp = Date()
        self.formattedDate = formattedDate
        self.client = client
    }
    
}
