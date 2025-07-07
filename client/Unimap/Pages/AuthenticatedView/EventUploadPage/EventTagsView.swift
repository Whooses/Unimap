//
//  EventTagsView.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-07-01.
//

import SwiftUI

struct EventTagsView: View {
    @EnvironmentObject var viewM: EventUploadVM
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
            //Show 3 input fields for tags; departments, categories and types
            VStack(spacing: 15) {
                TagInputField(
                    label: "Departments",
                    field: .departments, tags: $viewM.departments,
                    input: $viewM.departmentInput,
                    focusedField: $focusedField,
                    holder: "i.e. Computer Science, AI...",
                )
                
                TagInputField(
                    label: "Categories",
                    field: .categories, tags: $viewM.categories,
                    input: $viewM.categoryInput,
                    focusedField: $focusedField,
                    holder: "i.e. Social, Networking...",
                )
                
                TagInputField(
                    label: "Types",
                    field: .types, tags: $viewM.types,
                    input: $viewM.typeInput,
                    focusedField: $focusedField,
                    holder: "i.e. Conference, Promotion...",
                )
            }
            .padding(.bottom, 20)
        
  }
    
}

//MARK: Tag Input Field 
private struct TagInputField: View {
    var label: String
    var field: FocusedField
    @Binding var tags: [String]
    @Binding var input: String
    @FocusState.Binding var focusedField: FocusedField?
    var holder: String
    @EnvironmentObject var viewM: EventUploadVM

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.callout.bold())

                HStack {
                    TextField(holder, text: $input)
                        .onSubmit {
                            viewM.addTag(input: input, type: field)
                        }
                    
                    Button(action: {viewM.addTag(input: input, type: field)}) { //Button when clicked adds the tag to given array
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
                    }
                    .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(viewM.borderColor(for: field, currentFocus: focusedField), lineWidth: 1.5)
                )
                .focused($focusedField, equals: field)
                .animation(.easeInOut(duration: 0.2), value: focusedField)
            }
            
            // Display tags
            if !tags.isEmpty {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100), spacing: 8)
                ], spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        TagComponent(tag: tag) {
                            viewM.removeTag(tag: tag, type: field)
                        }
                    }
                }
                .padding(.top, 4)
            }
        }
    }
    
}


//// MARK: - Preview
//struct EventTagsInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        @StateObject var model = EventUploadVM()
//        NavigationView {
//            EventTagsView(viewM: model)
//        }
//    }
//}
