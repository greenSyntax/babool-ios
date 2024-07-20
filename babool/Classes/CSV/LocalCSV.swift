//
//  LocalCSV.swift
//  babool
//
//  Created by Abhishek Kumar Ravi on 20/07/24.
//

import Foundation

final class LocalCSV {
    
    private var csvFileName: String = "Logfile"
    private let writeQueue = DispatchQueue(label: "babool-csv-logger")
    private let fileManager: FileManager = FileManager.default
    
    private var documentsURL: URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm:ss a"
        return dateFormatter
    }()
    
    init?() {
        if !isAuthorziedToWriteOnFile() { return nil }
    }
    
    func setFileName(_ name: String) {
        self.csvFileName = name
    }
    
    /*
     <key>UIFileSharingEnabled</key>
     <true/>
     */
    private func isAuthorziedToWriteOnFile() -> Bool {
        var haveKeys = true
        
        if let infoDict = Bundle.main.infoDictionary {
            let filSharingKey = "UIFileSharingEnabled"
            let documentSupport = "UISupportsDocumentBrowser"
            if infoDict[filSharingKey] != nil && infoDict[documentSupport] != nil {
                return haveKeys
            }
        }
        return !haveKeys
    }
    
    func write(payload: PayloadProtocol) {
        guard let fileURL = documentsURL?.appendingPathComponent("\(csvFileName).csv") else { return }
        writeQueue.async { [weak self] in
            guard let self else { return }
            
            let dataString = "\(payload.uuid),\(payload.title),\(payload.description),\(payload.category),\(dateFormatter.string(from: payload.timestamp))\n"
            
            if self.fileManager.fileExists(atPath: fileURL.path) {
                if let fileHandle = try? FileHandle(forWritingTo: fileURL), let data = dataString.data(using: .utf8) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                    print("✅ [Babool] Success: ", payload.uuid)
                }
            } else {
                var csvString = payload.getCollumnNamedString()
                csvString.append(dataString)
                do {
                    try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("❌ [Babool] Error: ", error.localizedDescription)
                }
            }
        }
    }
    
}
