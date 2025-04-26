//
//import Foundation
//
//// A helper class to manage the building of the API URL
//class APIHelper {
//    static func buildAPIUrl(filterSelections: [Filter: String], filterOptions: [Filter: [String]]) -> URL? {
//        var components = URLComponents(string: "http://127.0.0.1:8000/events")!
//        var queryItems = [URLQueryItem]()
//        
//        if let selection = filterSelections[.departments],
//           let defaultOption = filterOptions[.departments]?.first,
//           selection != defaultOption {
//            queryItems.append(URLQueryItem(name: "departments", value: selection.lowercased()))
//        }
//        if let selection = filterSelections[.clubs],
//           let defaultOption = filterOptions[.clubs]?.first,
//           selection != defaultOption {
//            queryItems.append(URLQueryItem(name: "clubs", value: selection.lowercased()))
//        }
//        if let selection = filterSelections[.categories],
//           let defaultOption = filterOptions[.categories]?.first,
//           selection != defaultOption {
//            queryItems.append(URLQueryItem(name: "categories", value: selection.lowercased()))
//        }
//        if let selection = filterSelections[.date],
//           selection != Filter.date.rawValue {
//            let parts = selection.components(separatedBy: " - ")
//            if parts.count == 2 {
//                let inputFormatter = DateFormatter()
//                inputFormatter.dateStyle = .medium
//                let outputFormatter = DateFormatter()
//                outputFormatter.dateFormat = "yyyy-MM-dd"
//                if let start = inputFormatter.date(from: parts[0]),
//                   let end = inputFormatter.date(from: parts[1]) {
//                    queryItems.append(URLQueryItem(name: "start_date", value: outputFormatter.string(from: start)))
//                    queryItems.append(URLQueryItem(name: "end_date", value: outputFormatter.string(from: end)))
//                }
//            }
//        }
//        components.queryItems = queryItems
//        let url = components.url
//        print("API Call: \(String(describing: url))")
//        return url
//    }
//}
