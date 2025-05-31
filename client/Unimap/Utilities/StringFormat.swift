import Foundation

func dateRangeString(from startDate: Date?, to endDate: Date?) -> String {
    let calendar = Calendar.current
    let now = Date()
    let currentYear = calendar.component(.year, from: now)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale.current

    func format(_ date: Date) -> String {
        let year = calendar.component(.year, from: date)
        if year == currentYear {
            dateFormatter.dateFormat = "MM/dd"
        } else {
            dateFormatter.dateFormat = "MM/dd/yyyy"
        }
        return dateFormatter.string(from: date)
    }

    if let start = startDate, let end = endDate {
        return "\(format(start)) - \(format(end))"
    } else if let start = startDate {
        return "From \(format(start))"
    } else if let end = endDate {
        return "Until \(format(end))"
    } else {
        return "Date"
    }
}


func stringDate(date: Date?, placeholder: String = "") -> String {
    guard let date = date else { return placeholder }
    
    // Reuse formatter instances for performance
    struct Cache {
        // For absolute date formatting (e.g. "March 10, 2006")
        static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "MMMM d, yyyy"
            return df
        }()
        
        // For relative-date formatting (e.g. "in 3 days", "5 days ago")
        static let relativeFormatter: RelativeDateTimeFormatter = {
            let rf = RelativeDateTimeFormatter()
            rf.locale = Locale.current
            rf.unitsStyle = .full
            return rf
        }()
    }
    
    let now = Date()
    let oneWeekInSeconds: TimeInterval = 7 * 24 * 60 * 60
    let interval = date.timeIntervalSince(now)
    
    if abs(interval) <= oneWeekInSeconds {
        // Within one week: show "in X days"/"X days ago"
        return Cache.relativeFormatter.localizedString(for: date, relativeTo: now)
    } else {
        // Outside one-week range: show full English date
        return Cache.dateFormatter.string(from: date)
    }
}

