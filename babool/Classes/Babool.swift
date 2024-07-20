//
//  Babool.swift
//  babool
//
//  Created by Abhishek Ravi on 14/07/24.
//

import Foundation
import GoogleSignIn

public enum BoardType {
    case googleSheet(sheetId: String)
    case localSheet(csvName: String)
}

public class BaboolBoard {
    
    private var boardType: BoardType
    
    private lazy var csvLogger: LocalCSV? = {
        let csvLogger = LocalCSV()
        return csvLogger
    }()
    
    public init(boardType: BoardType) {
        self.boardType = boardType
    }
    
    public func setupGoogleSignin(vc: UIViewController) {
        let signInConfig = GIDConfiguration.init(clientID: "clientID-XYZ")
        GIDSignIn.sharedInstance.configuration = signInConfig
    }
    
    public func handleOpenURL(_ url: URL) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
        //sharedInstance.handle(url)
    }
    
    public func write(payload: PayloadProtocol) {
        switch self.boardType {
        case .googleSheet(sheetId: let googleSheetId):
            //TODO:
            print("WIP: \(googleSheetId)")
        case .localSheet(csvName: let csvName):
            guard let csvLogger = self.csvLogger else {
                fatalError("⚠️ Please add key in your Info.plist : <key>UIFileSharingEnabled</key> as TRUE")
            }
            csvLogger.setFileName(csvName)
            csvLogger.write(payload: payload)
        }
    }
    
}
