//
//  Babool.swift
//  babool
//
//  Created by Abhishek Ravi on 14/07/24.
//

import Foundation
import GoogleSignIn

public enum BoardType {
    case googleSheet(apiPath: URL)
    case localSheet(csvName: String)
}

public class BaboolBoard {
    
    private var boardType: BoardType
    private var googleSheet: GoogleSheetManager?
    
    private lazy var csvLogger: LocalCSV? = {
        let csvLogger = LocalCSV()
        return csvLogger
    }()
    
    
    public init(boardType: BoardType) {
        self.boardType = boardType
    }
    
    public func write(payload: PayloadProtocol) {
        switch self.boardType {
        case .googleSheet(apiPath: let apiPath):
            self.googleSheet = GoogleSheetManager(apiPath: apiPath)
            googleSheet?.write(payload: payload)
        case .localSheet(csvName: let csvName):
            guard let csvLogger = self.csvLogger else {
                fatalError("⚠️ Please add key in your Info.plist : <key>UIFileSharingEnabled</key> as TRUE")
            }
            csvLogger.setFileName(csvName)
            csvLogger.write(payload: payload)
        }
    }
    
}
