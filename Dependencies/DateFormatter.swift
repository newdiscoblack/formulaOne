//
//  DateFormatter.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 10/05/2021.
//

import Foundation

public protocol DateProviding {
    func dateFrom(
        _ string: String
    ) -> Date?
    
    func stringFrom(
        _ date: Date
    ) -> String
    
    func today()
    -> Date
    
    func print(
        _ type: DatePrinterType,
        from date: Date
    ) -> String
}

public protocol HasDateProvider {
    var dateProvider: DateProviding { get }
}

public class DateProvider: DateProviding {
    private var dateFormatter: DateFormatter
    private var datePrinter: DateFormatter
    private var timePrinter: DateFormatter

    public init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        datePrinter = DateFormatter()
        datePrinter.dateFormat = "EEEE, MMMM d yyyy"
        datePrinter.locale = Locale.current
        datePrinter.timeZone = TimeZone.current
        
        timePrinter = DateFormatter()
        timePrinter.dateFormat = "HH:mm"
        timePrinter.locale = Locale.current
        timePrinter.timeZone = TimeZone.current
    }
    
    public func dateFrom(
        _ string: String
    ) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    public func stringFrom(
        _ date: Date
    ) -> String {
        return dateFormatter.string(from: date)
    }
    
    public func today() -> Date {
        return Date()
    }
    
    public func print(
        _ type: DatePrinterType,
        from date: Date
    ) -> String {
        switch type {
        case .date:
            return datePrinter.string(from: date)
        case .time:
            return timePrinter.string(from: date)
        }
    }
}

public enum DatePrinterType {
    case date
    case time
}
