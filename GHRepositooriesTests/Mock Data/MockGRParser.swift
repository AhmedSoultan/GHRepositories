//
//  MockGRParser.swift
//  GHRepositooriesTests
//
//  Created by ahmed sultan on 22/09/2021.
//


import UIKit
@testable import GHRepositoories

class MockGRParser {
    
    var shouldReturnError = false
    
    func reset() {
        shouldReturnError = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getJson() -> [String:Any]? {
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "RepositoriesJson", ofType: "geojson") else {
            fatalError("json can not found")
        }
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("unable to convert json to string")
        }
        let jsondata = json.data(using: .utf8)!
        do {
            return try JSONSerialization.jsonObject(with: jsondata, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
        } catch {
            return nil
        }
    }
}

extension MockGRParser: ParsingProtocol {
 
    func parseResponse<ResponseType: Decodable>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? {
        
        // shouldReturnError simulate the failure

        if shouldReturnError {
            return nil
        } else {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else {
                fatalError("could not get data from json object")
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            do {
                return try decoder.decode(ResponseType.self, from: jsonData)
            } catch {
                return nil
            }
        }
    }
    
    func parse<ResponseType>(_ jsonDict: [AnyHashable : Any], responseType: ResponseType.Type) -> ResponseType? where ResponseType : Decodable {
        
        // shouldReturnError simulate the failure
        
        if shouldReturnError {
            return nil
        } else {
            return parseResponse(jsonDict, responseType: responseType.self)
        }
    }
}
