//
//  Date+Helpers.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 21.04.2022.
//

import Foundation

extension Date {
    enum ReturnFormat {
        case daymonthyear
        case upcomingFormat
    }
    
    func convertDateToString(returnFormat: ReturnFormat) -> String {
        let calendar = Calendar.current
       
        var day = String(calendar.component(.day, from: self))
        if Int(day)! < 10 {
            day = "0\(day)"
        }
        
        var month = String(calendar.component(.month, from: self))
        if Int(month)! < 10 {
            month = "0\(month)"
        }
        
        var hours = String(calendar.component(.hour, from: self))
        if Int(hours)! < 10 {
            hours = "0\(hours)"
        }
        var minutes = String(calendar.component(.minute, from: self))
        if Int(minutes)! < 10 {
            minutes = "0\(minutes)"
        }
        
        let year = String(calendar.component(.year, from: self))
        
        let time = "\(hours):\(minutes)"
        
        switch returnFormat {
        case .daymonthyear:
            return "\(day) \(localizedMonth(month)) \(year)"
        case .upcomingFormat:
            if calendar.isDateInToday(self) {
                return "\(Localized.Date.Today) \(time)"
            } else if calendar.isDateInTomorrow(self) {
                return "\(Localized.Date.Tomorrow) \(time)"
            } else {
                return "\(day) \(localizedMonthShort(month)), \(time)"
            }
        }
    }
    
    private func localizedMonth(_ month: String) -> String{
        switch month {
        case "01":
            return Localized.Date.January
        case "02":
            return Localized.Date.February
        case "03":
            return Localized.Date.March
        case "04":
            return Localized.Date.April
        case "05":
            return Localized.Date.May
        case "06":
            return Localized.Date.June
        case "07":
            return Localized.Date.July
        case "08":
            return Localized.Date.August
        case "09":
            return Localized.Date.September
        case "10":
            return Localized.Date.October
        case "11":
            return Localized.Date.November
        case "12":
            return Localized.Date.December
        default:
            return ""
        }
    }
    
    private func localizedMonthShort(_ month: String) -> String{
        switch month {
        case "01":
            return Localized.Date.ShortJanuary
        case "02":
            return Localized.Date.ShortFebruary
        case "03":
            return Localized.Date.ShortMarch
        case "04":
            return Localized.Date.ShortApril
        case "05":
            return Localized.Date.ShortMay
        case "06":
            return Localized.Date.ShortJune
        case "07":
            return Localized.Date.ShortJuly
        case "08":
            return Localized.Date.ShortAugust
        case "09":
            return Localized.Date.ShortSeptember
        case "10":
            return Localized.Date.ShortOctober
        case "11":
            return Localized.Date.ShortNovember
        case "12":
            return Localized.Date.ShortDecember
        default:
            return ""
        }
    }
}

