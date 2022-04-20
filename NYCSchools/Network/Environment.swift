//
//  Environment.swift
//  NYCSchools
//

import Foundation

enum Environment {
    
    static let rootURLstring = "https://data.cityofnewyork.us"
    
    static let baseURL: URL = {
        guard let url = URL(string: rootURLstring) else {
          fatalError("Base URL is invalid")
        }
        return url
    }()
    
    static let schoolDirectoryURL: URL = {
        guard let url = URL(string: "\(rootURLstring)/resource/s3k6-pzi2.json") else {
          fatalError("School Directory URL is invalid")
        }
        return url
    }()
    
    static let satResultURL: URL = {
        guard let url = URL(string: "\(rootURLstring)/resource/f9bf-2cp4.json") else {
          fatalError("SAT Result URL is invalid")
        }
        return url
    }()
}


