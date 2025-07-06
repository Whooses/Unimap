//
//  EventUploadPage.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-06-30.
//
import SwiftUI

struct EventUploadPage: View {
    @StateObject private var viewM = EventUploadVM(eventService:EventService())
    @FocusState private var focusedField: FocusedField?
    @State private var showPicker = false
    @State private var submission = false
    

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                UploadTitleView()
                Spacer()
                //Title, location inputs
                LabeledTextField(label: "Event Title", text: $viewM.title, field: .title, focusedField: $focusedField, isMandatory: true, viewModel: viewM)
                LabeledTextField(label: "Event Location", text: $viewM.location, field: .location, focusedField: $focusedField, isMandatory: true, viewModel: viewM)
           
                // Description field
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.callout.bold())
                    TextField("Enter a quick description...", text: $viewM.description, axis: .vertical)
                        .lineLimit(3...4)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(viewM.borderColor(for: .description, currentFocus: focusedField), lineWidth: 1.5)
                        )
                        .focused($focusedField, equals: .description)
                        .animation(.easeInOut(duration: 0.2), value: focusedField)
                }
               
                
                //Departments, Categories & Types
                EventTagsView(viewM: viewM)
                
               // Date picker
                DateView(viewModel: viewM, showPicker: $showPicker)
                
               //In person, online selectors
                HStack(spacing: 30) {
                    SelectorButton(trigger: $viewM.isOnline, text: "Online", symbolTrue: "wifi", symbolFalse: "wifi.slash")
                    SelectorButton(trigger: $viewM.isInPerson, text: "In Person", symbolTrue: "person.fill", symbolFalse: "person.slash.fill")
                } .frame(maxWidth: .infinity, alignment: .center)
                
                //Simple loading screen
                if viewM.isLoading {
                    ShowProgressView()
                }
               
               //Submit button
                Button {
                    if viewM.validateMandatoryFields() {
                          Task {
                              await viewM.submitEvent()
                              if viewM.isSubmitted {
                                  submission.toggle()
                              }
                          }
                        submission.toggle()

                    }

                } label: {
                        Text("Submit")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.opacity(0.8))
                    )
                    .disabled(viewM.isLoading)
                
                //Show error message if upload fail occurs...
                if let error = viewM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.callout)
                        .transition(.opacity)
                        .animation(.easeInOut, value: viewM.errorMessage)
                }
                
                
        
            }
            .sheet(isPresented: $submission) { //Submission pop-up on successful submission
                VStack(spacing: 5) {
                    Text("🎉")
                         .fontWeight(.black)
                         .font(.system(size: 100))
                   Text("Thanks for submitting!")
                        .fontWeight(.bold)
                        .font(.title)
                   Text("Your event will be uploaded shortly.")
                        .font(.subheadline)
                        .foregroundStyle(Color.black.opacity(0.7))
               }
               .presentationDetents([.medium])
               .presentationDragIndicator(.visible)
               .onAppear {
                   viewM.resetSubmission(after: 7.0) {
                          submission = false
                    }
                }
            }
            .padding(.horizontal, 25)
        }

    
    }
}

//MARK: View to show progress bar
struct ShowProgressView: View {
    var body: some View {
        HStack(spacing: 10) {
            ProgressView()
            Text("Uploading event...")
                .font(.callout)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

//MARK: Upload Title
private struct UploadTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Add an Event")
                    .font(.largeTitle.bold())
                Spacer()
            }
            Text("Enter details for your event below.")
                .font(.subheadline)
                .foregroundStyle(Color.gray)
        }
    }
}

//MARK: Labelled text field for input
private struct LabeledTextField: View {
    let label: String
    @Binding var text: String
    var field: FocusedField
    @FocusState.Binding var focusedField: FocusedField?
    var isMandatory: Bool = false
    @ObservedObject var viewModel: EventUploadVM

    private var hasValidationError: Bool {
        viewModel.hasValidationError(text: text, isMandatory: isMandatory)
    }
   
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.callout.bold())
            
            HStack {
                TextField("Enter the \(label.lowercased())...", text: $text)
                Image(systemName: "textformat")
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(viewModel.borderColor(for: field, currentFocus: focusedField), lineWidth: 1.5)
            )
            .focused($focusedField, equals: field)
            .animation(.easeInOut(duration: 0.2), value: focusedField)
            
            // Error message
            if hasValidationError {
                Text("\(label) is required")
                    .padding(3)
                    .font(.caption)
                    .foregroundColor(.red)
                    
            }
        }
    }
}

//MARK: Holds the date selector
private struct DateView: View {
    @ObservedObject var viewModel: EventUploadVM
    @Binding var showPicker: Bool

    var body: some View {
        VStack(spacing:1) {
            HStack(spacing: 20){
                VStack(alignment: .center, spacing: 8) {
                    Text(viewModel.formattedDate)
                    Text(viewModel.formattedTime)
                }
                .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image(systemName:"calendar")
                    .font(.system(size:50))
                    .onTapGesture {
                        withAnimation {
                            showPicker.toggle()
                        }
                    }
            }
            .foregroundStyle(Color.gray)
            .padding(30)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
            )
            .sheet(isPresented: $showPicker) {
                VStack {
                   DatePicker(
                       "Select Date and Time",
                       selection: $viewModel.eventDate,
                       in: Date()...,
                       displayedComponents: [.date, .hourAndMinute]
                   )
                   .datePickerStyle(.graphical)
                   .labelsHidden()
                   .padding()
               }
               .presentationDetents([.medium])
               .presentationDragIndicator(.visible)
            }
            
        }
    }
}

//MARK: Generic selector button to toggle option
private struct SelectorButton: View {
    @Binding var trigger: Bool
    var text: String
    var symbolTrue: String
    var symbolFalse: String
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.4)) {
                trigger.toggle()
            }
        } label: {
            HStack {
                Image(systemName: trigger ? symbolTrue : symbolFalse)
                Text(text)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(trigger ? Color.blue.opacity(0.8) : Color.gray.opacity(0.7))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))

        }
    }
}


#Preview {
    EventUploadPage()
}


