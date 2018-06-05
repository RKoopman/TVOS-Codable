////
////  FuboDateStyler.swift
////  TVOS-Codable
////
////  Created by Raoul Koopman on 6/5/18.
////  Copyright © 2018 fuboTV. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//public class FuboDateStyler {
//
//    static func getString(forDate date: Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        let string = dateFormatter.string(from: date)
//
//        return string
//
//    }
//
//    static func getDayString(forDate date: Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEE"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        return string
//
//    }
//
//    static func getNameOfDayWithNumber(forDate date:Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEE dd"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        return string
//    }
//
//    static func getDayStringWithMonthDate(for date: Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEEE, MMM dd"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        return string
//    }
//
//    static func getDayTmrYstrString(forDate date:Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateStyle = .medium
//        dateFormatter.doesRelativeDateFormatting = true
//        //dateFormatter.dateFormat = "EE"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        return string
//    }
//
//
//    static func getShortTime(forDate date:Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .short
//
//        let string = dateFormatter.string(from: date)
//
//        return string
//    }
//
//    static func getShortTimeNoMinutes(forDate date:Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .short
//        dateFormatter.dateFormat = "ha"
//        let string = dateFormatter.string(from: date)
//
//        return string
//    }
//
//    static func getShortTimeNoAMPM(forDate date:Date?) -> String {
//        guard let date = date else {
//            return ""
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .short
//        var string = dateFormatter.string(from: date)
//        string = string.replacingOccurrences(of: "AM", with: "")
//        string = string.replacingOccurrences(of: "PM", with: "")
//        return string
//    }
//
//    static func getFormattedShortTime(for date:Date?, font:UIFont, smallFont:UIFont) -> NSMutableAttributedString {
//        guard let date = date else {
//            return NSMutableAttributedString(string: "")
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateStyle = .none
//        dateFormatter.timeStyle = .short
//        let string = dateFormatter.string(from: date)
//
//
//        let offset = font.capHeight - smallFont.capHeight
//        let attributedString = NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font])
//        if let range = string.lowercased().range(of:"am") {
//            let startPos = string.distance(from: string.startIndex, to: range.lowerBound)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: startPos, length:2))
//        }else if let range = string.lowercased().range(of:"pm") {
//            let startPos = string.distance(from: string.startIndex, to: range.lowerBound)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: startPos, length:2))
//        }
//
//
//        return attributedString
//    }
//
//
//    static func getFormattedShortTime(for string:String?, font:UIFont, smallFont:UIFont) -> NSMutableAttributedString {
//        guard let string = string else {
//            return NSMutableAttributedString(string: "")
//        }
//
//        let offset = font.capHeight - smallFont.capHeight
//        let attributedString = NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font])
//        if let range = string.lowercased().range(of:"am") {
//            let startPos = string.distance(from: string.startIndex, to: range.lowerBound)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: startPos, length:2))
//        } else if let range = string.lowercased().range(of:"pm") {
//            let startPos = string.distance(from: string.startIndex, to: range.lowerBound)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: startPos, length:2))
//        }
//
//
//        return attributedString
//    }
//
//    static func getFormattedDateSportsCalenderAlreadyFormatted(for string:String?, font:UIFont, smallFont:UIFont) -> NSMutableAttributedString {
//        guard let string = string else {
//            return NSMutableAttributedString(string: "")
//        }
//
//        if string.contains(L10n.today.string.uppercased()) {
//            let todayFont = UIStyler.Font.Qanelas.getBlackFont(font.pointSize)
//            return NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:todayFont])
//        }
//
//        let offset = font.capHeight - smallFont.capHeight
//        let attributedString = NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font])
//        if let range = string.range(of:" ") {
//            let length = string.distance(from: range.upperBound, to: string.endIndex)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: range.upperBound.encodedOffset, length:length))
//        }
//
//        return attributedString
//    }
//
//    static func getFormattedDateSportsCalender(for string:String?, font:UIFont, smallFont:UIFont) -> NSMutableAttributedString {
//        guard let string = string else {
//            return NSMutableAttributedString(string: "")
//        }
//
//        if string.contains(L10n.today.string.uppercased()) {
//            let todayFont = UIStyler.Font.Qanelas.getBlackFont(font.pointSize)
//            return NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:todayFont])
//        }
//
//        let df = DateFormatter()
//        df.timeZone = TimeZone(abbreviation: "UTC")
//        df.dateFormat = "MMM dd"
//
//        if let date = FuboDateStyler.getDate(forString: string, format:"MMM dd") {
//            let newDateString = df.string(from: date).uppercased()
//            let offset = font.capHeight - smallFont.capHeight
//            let attributedString = NSMutableAttributedString(string: newDateString, attributes:[NSFontAttributeName:font])
//            if let range = string.range(of:" ") {
//                let length = string.distance(from: range.upperBound, to: newDateString.endIndex)
//                attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: range.upperBound.encodedOffset, length:length))
//            }
//            return attributedString
//        }
//
//        return NSMutableAttributedString(string: "")
//    }
//
//    static func getFormattedDateWithNameNumberTime(for date:Date?, dayName:String? = nil, font:UIFont, timeFont:UIFont, timeSuffixFont:UIFont) -> NSMutableAttributedString{
//        guard let date = date else {
//            return NSMutableAttributedString(string: "")
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEE"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        let mString = dayName == nil ? NSMutableAttributedString(string: string) : NSMutableAttributedString(string:dayName!)
//        mString.append(NSAttributedString(string:" "))
//        mString.append(getFormattedShortTime(for: date, font:timeFont, smallFont:timeSuffixFont))
//
//
//        return mString
//    }
//
//    static func getFormattedDateWithNameNumber(for date:Date?, dayName:String? = nil, font:UIFont, numberFont:UIFont) -> NSMutableAttributedString {
//        guard let date = date else {
//            return NSMutableAttributedString(string: "")
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEE"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        let mString = dayName == nil ? NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font]) : NSMutableAttributedString(string:dayName!, attributes:[NSFontAttributeName:font])
//        mString.append(NSAttributedString(string:" "))
//
//
//        dateFormatter.dateFormat = "dd"
//        let numberOfDay = dateFormatter.string(from: date)
//        mString.append(NSMutableAttributedString(string: numberOfDay, attributes:[NSFontAttributeName:numberFont]))
//
//        return mString
//    }
//
//    static func getFormattedDateWithDayMonthNumber(for date:Date?, dayName:String? = nil, font:UIFont, numberFont:UIFont) -> NSMutableAttributedString {
//        guard let date = date else {
//            return NSMutableAttributedString(string: "")
//        }
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "EEE"
//        let string = dateFormatter.string(from: date).uppercased()
//
//        let mString = dayName == nil ? NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font]) : NSMutableAttributedString(string:dayName!, attributes:[NSFontAttributeName:font])
//        mString.append(NSAttributedString(string:" "))
//
//
//        dateFormatter.dateFormat = "MMM dd"
//        let numberOfDay = dateFormatter.string(from: date)
//        mString.append(NSMutableAttributedString(string: numberOfDay, attributes:[NSFontAttributeName:numberFont]))
//
//        return mString
//    }
//
//    static func getFormattedStringSearch(for string:String?, font:UIFont, smallFont:UIFont) -> NSMutableAttributedString {
//        guard let string = string else {
//            return NSMutableAttributedString(string: "")
//        }
//
//        let offset = font.capHeight - smallFont.capHeight
//        let attributedString = NSMutableAttributedString(string: string, attributes:[NSFontAttributeName:font])
//        if let range = string.range(of:" ") {
//            let length = string.distance(from: range.upperBound, to: string.endIndex)
//            attributedString.setAttributes([NSFontAttributeName:smallFont, NSBaselineOffsetAttributeName:offset], range: NSRange(location: range.upperBound.encodedOffset, length:length))
//        }
//
//        return attributedString
//    }
//
//    static func getDate(forString string:String?) -> Date? {
//        guard let str = string else {
//            return nil
//        }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        let date = dateFormatter.date(from: str)
//
//        return date
//    }
//
//    static func getDate(forString string:String?, format:String) -> Date? {
//        guard let str = string else {
//            return nil
//        }
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = format
//        let date = dateFormatter.date(from: str)
//
//        return date
//    }
//
//    static func formattedExpirationDate(_ date:Date) -> String {
//        let dateFormatter = DateFormatter()
//        let format2:String = "MMM d, yyyy"
//
//        dateFormatter.dateFormat = format2
//
//        return dateFormatter.string(from: date)
//    }
//
//    static func formattedExpirationDateWithYTT(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        let calendar = Calendar.current
//        let currentDate = Date()
//
//        let format:String = ", 'MMM d"
//        let format2:String = "MMM d, yyyy"
//
//        var dayComponent = DateComponents()
//        dayComponent.day = 1
//
//        let tomorrow = calendar.date(byAdding: dayComponent, to: currentDate)
//        dayComponent.day = -1
//        let yesterday = calendar.date(byAdding: dayComponent, to: currentDate)
//
//        if currentDate.sameDay(date: date) {
//            dateFormatter.dateFormat = "'\(L10n.today.string)" + format
//        }else if let yd = yesterday, date.sameDay(date: yd){
//            dateFormatter.dateFormat = "'\(L10n.yesterday.string)" + format
//        }else if let t = tomorrow, date.sameDay(date: t){
//            dateFormatter.dateFormat = "'\(L10n.tomorrow.string)" + format
//        }
//        else {
//            dateFormatter.dateFormat = format2
//        }
//
//        return dateFormatter.string(from: date)
//    }
//
//    static func getDateLabelText(tmrText:Bool, endedText:Bool = true, eventStartDate:Date?, eventEndDate:Date?) -> String {
//        guard let eventStartDate = eventStartDate, let eventEndDate = eventEndDate else {
//            return ""
//        }
//
//        let comparisonResult = eventEndDate.compareDay(with: Date())
//        let current = Date()
//
//        switch comparisonResult {
//        //past
//        case .orderedAscending: return FuboDateStyler.getPastDateLabel(eventStartDate: eventStartDate)
//        //today
//        case .orderedSame :
//            let endStartIsInSameDay = eventStartDate.sameDay(date:eventEndDate)
//            if endStartIsInSameDay {
//                return FuboDateStyler.getTodayDateLabel(eventStartDate: eventStartDate, eventEndDate: eventEndDate, endedText: endedText)
//            }else {
//                return FuboDateStyler.getPastDateLabel(eventStartDate: eventStartDate)
//            }
//        //future
//        case .orderedDescending:
//            if eventStartDate.sameDay(date: current) {
//                return FuboDateStyler.getTodayDateLabel(eventStartDate: eventStartDate, eventEndDate: eventEndDate)
//            }
//
//            return FuboDateStyler.getFutureDateLabel(tmrText: tmrText, eventStartDate: eventStartDate)
//        }
//    }
//
//    static func getTodayDateLabel(eventStartDate:Date? = nil, eventEndDate:Date? = nil, endedText:Bool = false) -> String {
//        guard let eventEnd = eventEndDate, let eventStart = eventStartDate else {
//            return L10n.today.string.uppercased()
//        }
//
//        let current = Date()
//
//        let nightTreshold = Date().setTime(hour: 18, min: 0, sec: 0)
//
//        if eventEnd < current {
//            let text = endedText ? L10n.ended.string.uppercased() : L10n.today.string.uppercased()
//            return text
//        }else if eventStart <= current && current < eventEnd {
//            return L10n.live.string.uppercased()
//        }else if let nightTreshold = nightTreshold, eventStart >= nightTreshold {
//            return L10n.tonight.string.uppercased()
//        }else {
//            return L10n.today.string.uppercased()
//        }
//    }
//
//    static func getPastDateLabel(eventStartDate:Date? = nil) -> String {
//        guard let date = eventStartDate, date < Date() else {
//            return ""
//        }
//
//        let dateFormatter = DateFormatter()
//        let calendar = Calendar.current
//        let currentDate = Date()
//
//        let countOfPastDays = 3
//        var format = "MMM d"
//
//        var dayComponent = DateComponents()
//        dayComponent.day = -countOfPastDays
//        let pastTreshold = calendar.date(byAdding: dayComponent, to: currentDate)?.setTime(hour: 0, min: 0, sec: 0)
//
//        if let pastTreshold = pastTreshold, date >= pastTreshold {
//            format = "EEE"
//        }
//
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: date).uppercased()
//
//
//    }
//
//    static func getFutureDateLabel(tmrText:Bool, eventStartDate:Date? = nil) -> String {
//        guard let date = eventStartDate, date > Date() else {
//            return ""
//        }
//
//        let dateFormatter = DateFormatter()
//        let calendar = Calendar.current
//        let currentDate = Date()
//
//        var format = "MMM d"
//        var dayComponent = DateComponents()
//        dayComponent.day = 1
//        let tmr = calendar.date(byAdding: dayComponent, to: currentDate)
//
//        dayComponent.day = 3
//        let futureTreshold = calendar.date(byAdding: dayComponent, to: currentDate)?.setTime(hour: 23, min: 59, sec: 59)
//
//        if let tmr = tmr, date.sameDay(date: tmr), tmrText {
//            return L10n.tomorrow.string.uppercased()
//        }
//        else if let futureTresh = futureTreshold, date <= futureTresh {
//            format = "EEE"
//        }
//
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: date).uppercased()
//    }
//}
//
////MARK: - Duration
//
//extension FuboDateStyler {
//
//    static func formattedDuration(fromDate: Date, toDate: Date) -> String {
//        let seconds = fromDate.timeIntervalSince(toDate)
//        return FuboDateStyler.formattedDuration(seconds)
//    }
//
//    static func formattedDuration(_ seconds: TimeInterval, includeSeconds: Bool = true) -> String {
//
//        var retString = ""
//
//        let (hr, _) = modf(seconds / 3600)
//        let (min, secf) = modf((seconds-(hr*3600))/60)
//
//        let hourStr = NSString(format: "%.0f ", hr) as String + L10n.hours.string
//        let minStr = NSString(format: "%.0f ", min) as String + L10n.minutes.string
//        let secStr = NSString(format: "%.0f ", (secf * 60)) as String + L10n.seconds.string
//
//        if hr > 0 {
//            retString = hourStr
//        }
//
//        if min > 0 {
//            retString = retString.isEmpty ? minStr : retString + " " + minStr
//        }
//
//        if secf > 0 && includeSeconds {
//            retString = retString.isEmpty ? secStr : retString + " " + secStr
//        }
//
//        return retString
//    }
//}
//
////MARK: Player
//
//extension FuboDateStyler {
//
//    static func formattedTimeForPlayer(from date: Date) -> String {
//        return playerDateFormatter.string(from: date)
//    }
//
//    private static let playerDateFormatter: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mma"
//        return dateFormatter
//    }()
//
//}
//
////Analytics
//extension FuboDateStyler {
//    static func daysBetween(_ start: Date,_ end: Date) -> Int {
//        let calendar = Calendar.current
//
//        // Replace the hour (time) of both dates with 00:00
//        let date1 = calendar.startOfDay(for: start)
//        let date2 = calendar.startOfDay(for: end)
//
//        let a = calendar.dateComponents([.day], from: date1, to: date2)
//        return a.value(for: .day)!
//    }
//}
//
//extension FuboDateStyler {
//    static func rfc3339DateTimeStringForDate(date: Date) -> String {
//        let en_US_POSIX = Locale(identifier: "en_US_POSIX")
//        let rfc3339DateFormatter = DateFormatter()
//        rfc3339DateFormatter.locale = en_US_POSIX
//        rfc3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        rfc3339DateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        return rfc3339DateFormatter.string(from: date)
//    }
//}
//
//
