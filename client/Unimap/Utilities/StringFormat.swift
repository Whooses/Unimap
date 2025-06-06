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


func stringDate(Date date: Date?,
            format: String = "yyyy-MM-dd",
            placeholder: String = "") -> String {
    
    guard let date else { return placeholder }
    
    // Re-use the same formatter instance for speed.
    struct Cache {
        static var formatter = DateFormatter()
    }
    
    let formatter = Cache.formatter
    if formatter.dateFormat != format {
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
    }
    return formatter.string(from: date)
}
