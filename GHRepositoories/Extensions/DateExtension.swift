//
//  DateExtension.swift
//  GHRepositoories
//
//  Created by ahmed sultan on 22/09/2021.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM YYYY"
        return dateFormater.string(from: self)
    }
}
