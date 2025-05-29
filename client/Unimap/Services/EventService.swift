import Foundation

class EventService {
    private let networkService = NetworkService()

    // MARK: User specific services
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
    
    func fetchUserEvents() async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }
    

    // MARK: School base service
    
    func fetchLatestEvents(user: User?) async throws -> [Event] {
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
        let builder = URLRequestBuilder(forEventsService: true)
            .setSearch(search ?? "")
            .setPlatform(tab)
            .setSort(filter.sort)
            .setClubs(filter.clubs)
            .setDateRange(filter.startDate, filter.endDate)
        
        do {
            let request = try builder.build()
            let data: [Event] = try await networkService.sendRequest(from: request, type: [Event].self)
            
            return data
            
        } catch let error as URLRequestBuilderError {
            print(error.localizedDescription)
            
            throw error
        } catch let error as NetworkError {
            print(error.localizedDescription)
            
            // TODO: Implement better error handling logic later
            throw error
        } catch {
            print("Unexpected error: \(error.localizedDescription)")
            
            throw error
        }
    }
}
