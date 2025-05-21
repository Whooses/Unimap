import Foundation

class NewEventService {
    private let networkService = NetworkService()

    func fetchRecommendationEvents(user: User) async throws -> [Event] {
        fatalError()
    }

    func fetchUserUpcomingEvents() async throws -> [Event] {
        fatalError()
    }

    func fetchuserEvents() async throws -> [Event] {
        fatalError()
    }

    func fetchExploreEvents(
            search: String? = nil,
            tab: ExploreTab,
            filter: ExploreFilter
    ) async throws -> [Event] {
        let builder = NewEventRequestBuilder()
            .setSearch(search)
            .setTab(tab)
            .setSort(filter.sort)
            .setClubs(filter.clubs)
            .setDateRange(start: filter.startDate, end: filter.endDate)

        guard let request = builder.build() else {
            throw NSError(
                domain: "NewEventService",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Could not build request"]
            )
        }
        
        do {
            let data: [Event] = try await self.networkService.sendRequest(from: request, type: Event.self)
            return data
        } catch {
            throw error
        }
    }
}
