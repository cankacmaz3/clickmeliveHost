//
//  String+Extensions.swift
//  ClickmeliveHostCore
//
//  Created by Can Kaçmaz on 22.04.2022.
//

import Foundation

extension String {
    func phoneFormat(shouldRemoveLastDigit: Bool = false) -> String {
        guard !self.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: self).range(of: self)
        var number = regex.stringByReplacingMatches(in: self, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if(number.count == 1 && self != "0"){
            number = "0" + number
        }
        
        if number.count < 8 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: range)
            
        }else if number.count < 10 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d+)", with: "$1 $2 $3 $4", options: .regularExpression, range: range)
            
        }else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{1})(\\d{3})(\\d{3})(\\d{2})(\\d+)", with: "$1 $2 $3 $4 $5", options: .regularExpression, range: range)
        }
        
        if number.count > 15 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 15)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        return number
    }
    
    func phoneUnformat() -> String {
        var unformat = self.replacingOccurrences(of: " ", with: "")
        if(unformat.prefix(1) == "0"){
            unformat.remove(at: unformat.startIndex)
        }
        
        return unformat
    }
    
    func parse<D>(to type: D.Type) -> D? where D: Decodable {
        let data: Data = self.data(using: .utf8)!
        let decoder = JSONDecoder()

        do {
            let _object = try decoder.decode(type, from: data)
            return _object

        } catch {
            return nil
        }
    }
}
