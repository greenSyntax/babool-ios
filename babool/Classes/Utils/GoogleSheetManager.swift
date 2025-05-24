//
//  GoogleSheetManager.swift
//  babool
//
//  Created by Abhishek Ravi on 14/07/24.
//

import Foundation

struct Wrapper: Codable {
    let data: [String: [String]]
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
    
    /*
     As per API Contarct, JSON will look like this,
     {
         "data": [
             "1748073980",
             "error",
             "failed_listing_api",
             "{error: '500 Server Error'}",
             "23-06-2025",
             "alankaar-ios"
         ]
     }
     */
    
    private func toData(_ dict: [String: [String]]) -> Data? {
        let wrapper = Wrapper(data: dict)
        if let data = try? JSONEncoder().encode(wrapper) { return data }
        return nil
    }
    
    private func sendToBuckbeak(payload: PayloadProtocol) {
        var request = URLRequest(url: buckbeackAPI)
        request.httpMethod = "POST"
        request.httpBody = toData(["data": [
            payload.timestamp.formattedString(),
            payload.type,
            payload.description,
            payload.formattedDate,
            payload.client
        ]])
        
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
