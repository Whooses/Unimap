import Foundation

class NewEventService {
    private let networkService = NetworkService()

    func fetchRecEvents(user: NewUser?) async throws -> [NewEvent] {
        return [
            NewEvent(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }

    func fetchUpcomingEvents(user: NewUser?) async throws -> [NewEvent] {
        return [
            NewEvent(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
    
    func fetchLatestEvents(user: NewUser?) async throws -> [NewEvent] {
        return [
            NewEvent(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
    
    

    func fetchuserEvents() async throws -> [NewEvent] {
        fatalError()
    }

    func fetchExploreEvents(
            search: String? = nil,
            tab: ExploreTab,
            filter: ExploreFilter
    ) async throws -> [NewEvent] {
//        let builder = NewEventRequestBuilder()
//            .setSearch(search)
//            .setTab(tab)
//            .setSort(filter.sort)
////            .setClubs(filter.clubs)
//            .setDateRange(start: filter.startDate, end: filter.endDate)
//
//        guard let request = builder.build() else {
//            throw NSError(
//                domain: "NewEventService",
//                code: 1,
//                userInfo: [NSLocalizedDescriptionKey: "Could not build request"]
//            )
//        }
//        
//        do {
//            let data: [NewEvent] = try await self.networkService.sendRequest(from: request, type: NewEvent.self)
//            return data
//        } catch {
//            throw error
//        }
        return [
            NewEvent(id: 1, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 1, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 2, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 2, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 3, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 3, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 4, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 4, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 5, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 5, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 6, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 6, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 7, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 7, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 8, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 8, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
            NewEvent(id: 9, title: "Party Night", imageURL: URL(string: "https://shorturl.at/ISmcS"),user: NewUser(userID: 9, name: "Whooses", pfpURL: URL(string: "https://shorturl.at/vYd1A") ,isVerified: false)),
        ]
    }
}
