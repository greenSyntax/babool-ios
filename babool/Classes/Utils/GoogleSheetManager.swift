//
//  GoogleSheetManager.swift
//  babool
//
//  Created by Abhishek Ravi on 14/07/24.
//

import Foundation

extension Collection where Element == String {
    
    /// Converts the collection into a single string with a custom separator
    func joinedString(separator: String = "\n") -> String {
        return self.joined(separator: separator)
    }
    
    /// Converts the joined string into Data using UTF-8 encoding
    func asData(separator: String = "\n") -> Data? {
        return self.joined(separator: separator).data(using: .utf8)
    }
}

extension TimeInterval {
    /// Converts a UNIX timestamp (TimeInterval) to a formatted date string
    func formattedDateString(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        let date = Date(timeIntervalSince1970: self)
        return date.formattedString(format: format, timeZone: timeZone)
    }
}

extension Date {
    /// Converts a Date to a formatted string
    func formattedString(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}

class GoogleSheetManager {

    private let buckbeackAPI: URL
    
    var onCompletion: ((_ error: Error?) -> Void)?
    
    init(apiPath: URL) {
        buckbeackAPI = apiPath
    }
    
    func write(payload: PayloadProtocol) {
        sendToBuckbeak(payload: payload)
    }
    
    private func toData(_ data: [String]) -> Data? {
        let d = data.joinedString()
        return d.data(using: .utf8)
    }
    
    private func sendToBuckbeak(payload: PayloadProtocol) {
        var request = URLRequest(url: buckbeackAPI)
        request.httpMethod = "POST"
        request.httpBody = toData([
            payload.timestamp.formattedString(),
            payload.type,
            payload.description,
            payload.formattedDate,
            payload.client
        ])
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse,
                let httpData = data {
                    let httpStatusCode = httpResponse.statusCode
                    if httpStatusCode == 200 {
                        let responseInString = String(data: httpData, encoding: .utf8)
                        // print("Buckbeak Response: \(responseInString)")
                        self?.onCompletion?(nil)
                    } else {
                        self?.onCompletion?(NSError(domain: "Failed HTTP Code", code: -100))
                    }
                } else {
                    self?.onCompletion?(error)
                }
            }
        }.resume()
    }
    
}
