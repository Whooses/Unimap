//
//  EventUploadVM.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-07-01.
//

import Foundation
import SwiftUI
//Enum - focused field for text inputs
enum FocusedField: Hashable {
    case title, description, location, departments, categories, types
}

@MainActor
class EventUploadVM: ObservableObject {
      //MARK: UI Var - Focus state, toggle var
      @Published var focusedField: FocusedField?
      // MARK: - Input Fields
      @Published var title: String = ""
      @Published var description: String = ""
      @Published var location: String = ""

      // MARK: - Toggles
      @Published var isOnline: Bool = false
      @Published var isInPerson: Bool = false

      // MARK: - Date
      @Published var eventDate: Date = Date()

      // MARK: - Tag Fields
      @Published var departments: [String] = []
      @Published var categories: [String] = []
      @Published var types: [String] = []

      @Published var departmentInput: String = ""
      @Published var categoryInput: String = ""
      @Published var typeInput: String = ""
    
    //MARK: - Computed properties
    var formattedDate: String {
        eventDate.formatted(.dateTime.weekday(.abbreviated).month(.abbreviated).day())
    }

    var formattedTime: String {
        eventDate.formatted(.dateTime.hour().minute())
    }
    
    // MARK: Private properties
    private let eventService: EventService
        
    // MARK: Init
    init(eventService: EventService) {
        self.eventService = eventService
    }

    // Error messages
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var isSubmitted: Bool = false
    
    
    /// Appends tags to the given array based on 'focusedfield' input
    /// - Returns: N/A
    func addTag(input: String, type: FocusedField) {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).capitalized(with: Locale(identifier: "en_US"))
        guard !trimmedInput.isEmpty else { return }
        switch type {
            case .departments:
                appendUnique(trimmedInput, to: &departments)
                departmentInput = ""
            case .categories:
                appendUnique(trimmedInput, to: &categories)
                categoryInput = ""
            case .types:
                appendUnique(trimmedInput, to: &types)
                typeInput = ""
            default: print("Did not enter the correct type to use this function")
            }
    }
    

    /// Removes all instances of a tag
    /// - Returns: N/A
    func removeTag(tag: String, type: FocusedField) {
          switch type {
              case .departments: departments.removeAll  { $0 == tag }
              case .categories: categories.removeAll  { $0 == tag }
              case .types: types.removeAll  { $0 == tag }
              default: print("Did not enter the correct type to use this function")
        }
    }
    
    /// Appends only UNIQUE instances of tags to the array
    /// - Returns: N/A
    private func appendUnique(_ tag: String, to array: inout [String]) {
        if !array.contains(tag) {
            array.append(tag)
        }
    }
    
    ///Validates a given arbituary field, based on whether string is mandated or not
    ///- Returns: Boolean to indicate whether valid or not
    func hasValidationError(text: String, isMandatory: Bool) -> Bool {
        return isMandatory && text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    
    /// Validates mandated fields for event upload
    /// - Returns: Boolean  to determine whether given mandated input(s) is proper
    func validateMandatoryFields() -> Bool {
        let isEventNameValid = !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isEventLocationValid = !location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return isEventNameValid && isEventLocationValid 
    }
    
    //MARK: Upload event function
    
    func submitEvent() async {
           isLoading = true
           errorMessage = nil

           let event = EventUpload(
               id: 0,
               user_id: 0,
               owner_id: 0,
               title: title,
               description: description.isEmpty ? nil : description,
               date: eventDate,
               location: location.isEmpty ? nil : location,
               imageURL: nil,
               isPublic: nil,
               userName: nil,
               departments: departments.isEmpty ? nil : departments,
               categories: categories.isEmpty ? nil : categories,
               clubs: nil,
               types: types.isEmpty ? nil : types,
               inPerson: isInPerson,
               online: isOnline
           )

           do {
               _ = try await eventService.uploadEvent(event)
               isSubmitted = true
           } catch {
               errorMessage = "Failed to upload event: \(error.localizedDescription)"
           }

           isLoading = false
        
            if isSubmitted {
                resetForm()
            }
    }
    
    //MARK: Miscellaneous functions
    
    /// Selects a given border colour based on current focused field
    /// - Returns: N/A
    func borderColor(for field: FocusedField, currentFocus: FocusedField?) -> Color {
        return currentFocus == field ? .blue : Color.gray.opacity(0.5)
    }

    /// Resets the form
    /// - Returns: N/A
    private func resetForm() {
        title = ""
        description = ""
        location = ""
        departments = []
        categories = []
        types = []
        departmentInput = ""
        categoryInput = ""
        typeInput = ""
        isOnline = false
        isInPerson = false
        eventDate = Date()
        isSubmitted = false

    }
    
    
    /// Reset submission for delay pop-up
    /// - Returns: N/A
    func resetSubmission(after seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    //MARK: Debugging
    
    /// Debugging, prints out array contents
    /// - Returns: N/A
     func printDebug() {
         // Print out contents
         print("title: \(title)")
         print("description: \(description)")
         print("location: \(title)")
         print("Departments: \(departments)")
         print("Categories: \(categories)")
         print("Types: \(types)")
         print("isOnline: \(isOnline)")
         print("isInperson: \(isInPerson)")
         print("date: \(eventDate)")

    }

}
