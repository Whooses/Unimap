import Foundation

class EventService {
    private let networkService = NetworkService()

    func fetchRecEvents(user: User?) async throws -> [Event] {
        return [
            Event(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }

    func fetchUpcomingEvents(user: User?) async throws -> [Event] {
        return [
            Event(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
    
    func fetchLatestEvents(user: User?) async throws -> [Event] {
        return [
            Event(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
    
    

    func fetchuserEvents() async throws -> [Event] {
        fatalError()
    }

    func fetchExploreEvents(
            search: String? = nil,
            tab: ExploreTab,
            filter: ExploreFilter
    ) async throws -> [Event] {
//        let builder = EventRequestBuilder()
//            .setSearch(search)
//            .setTab(tab)
//            .setSort(filter.sort)
////            .setClubs(filter.clubs)
//            .setDateRange(start: filter.startDate, end: filter.endDate)
//
//        guard let request = builder.build() else {
//            throw NSError(
//                domain: "EventService",
//                code: 1,
//                userInfo: [NSLocalizedDescriptionKey: "Could not build request"]
//            )
//        }
//        
//        do {
//            let data: [Event] = try await self.networkService.sendRequest(from: request, type: Event.self)
//            return data
//        } catch {
//            throw error
//        }
        return [
            Event(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            Event(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: User(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
}
