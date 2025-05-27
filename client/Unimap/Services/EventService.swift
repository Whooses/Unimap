import Foundation

class EventService {
    private let networkService = NetworkService()

    func fetchRecEvents(user: User?) async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }

    func fetchUpcomingEvents(user: User?) async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }
    
    func fetchLatestEvents(user: User?) async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }
    
    

    func fetchuserEvents() async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
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
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }
}
