import Foundation

class EventService {
    private let networkService = NetworkService()

    func uploadEvent(_ event: EventUpload) async throws -> EventUpload {
        let builder = URLRequestBuilder(forEventsService: true)
            .setPath("/events")
        builder.method = "POST"

        do {
            // Encode & print JSON for debugging
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)

            if let jsonData = try? encoder.encode(event),
            let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Sending JSON:\n\(jsonString)")
            }

            // Use builder's existing setJSONBody (make sure it uses the same encoder settings)
            try builder.setJSONBody(model: event)
            let request = try builder.build()
            let response: EventUpload = try await networkService.sendRequest(from: request, type: EventUpload.self)
            return response
        } catch let error as URLRequestBuilderError {
            print("URL builder error: \(error.localizedDescription)")
            throw error
        } catch let error as NetworkError {
            print("Network error: \(error.localizedDescription)")
            throw error
        } catch {
            print("Unexpected error: \(error.localizedDescription)")
            throw error
        }
    }


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


    func fetchUserEvents(
        skip: Int,
        limit: Int,
        userID: Int,
        sort: Sort = .latest
    ) async throws -> [Event] {
        let builder = URLRequestBuilder(forEventsService: true)
            .setPath("/events/user/\(userID)")
            .setSort(sort)
            .setPagination(skip, limit)

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


    // MARK: School base service

    func fetchLatestEvents(user: User?) async throws -> [Event] {
        return [
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock(),
            Event.mock(), Event.mock(), Event.mock()
        ]
    }


    func fetchExploreEvents(
        skip: Int,
        limit: Int,
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
            .setPagination(skip, limit)

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
