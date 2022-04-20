//
//  SatScores.swift
//  NYCSchools
//

import Foundation

struct SatScores: Decodable {
    
    var dbn: String?
    var schoolName: String?
    var totalTestTakers: String?
    var reading: String?
    var math: String?
    var writing: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case totalTestTakers = "num_of_sat_test_takers"
        case reading = "sat_critical_reading_avg_score"
        case math = "sat_math_avg_score"
        case writing = "sat_writing_avg_score"
    }
}
