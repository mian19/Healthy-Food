//
//  JSONManager.swift
//  Healthy Food
//
//  Created by Kyzu on 3.10.22.
//

import Foundation

class JSONManager {
    func fetchingInformation() -> JSONResponse? {
        guard let path = Bundle.main.path(forResource: "jsonviewer", ofType: "json") else { return nil}
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let jsonResponse: JSONResponse? = try JSONDecoder().decode(JSONResponse.self, from: jsonData)
            
            if let jsonResponse = jsonResponse {
                return jsonResponse
            }
        } catch {
            print(error)
        }
        return nil
    }
}
