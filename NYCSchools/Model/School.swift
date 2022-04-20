//
//  School.swift
//  NYCSchools
//

import Foundation

// https://data.cityofnewyork.us/resource/s3k6-pzi2.json

struct School: Decodable {
    
    var dbn: String?
    var schoolName: String?
    var overviewParagraph: String?
    var latitude: String?
    var longitude: String?
    var totalStudents: String?
    var location: String?
    var phone: String?
    var email: String?
    var website: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn, latitude, longitude, location, website
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case totalStudents = "total_students"
        case phone = "phone_number"
        case email = "school_email"
    }
}


