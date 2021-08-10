//
//  EventEditorView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/25.
//

import SwiftUI

struct EventEditorView: View {
    
    @Binding var event: SpendEvent
    
    // a Binding to a PresentationMode
    // which lets us dismiss() ourselves if we are isPresented
    @Environment(\.presentationMode) var presentationMode
    
    @State var budgetEntry: String = ""
    
    var body: some View {
        VStack {
            finishedButton
            Form {
                changeNameSection
                selectDateSection
                changeSpendingSection
                setCategorySection
                addMemorySection
            }
            .navigationTitle("Edit \(event.name)")
            .frame(minWidth: 300, minHeight: 350)
        }
    }
    
    var finishedButton: some View {
        HStack {
            Spacer()
            Button("Update") {
                if Double(budgetEntry) != nil {
                    event.spending = Double(budgetEntry)!
                }
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding([.top, .horizontal])
    }
    
    var changeNameSection: some View {
        Section(header: Text("Event Name")) {
            TextField("New Event", text: $event.name)
                .font(.system(size: 20))
        }
        
    }
    
    var selectDateSection: some View {
        Section(header: Text("Event Date")) {
            DatePicker(
                "Choose Date",
                selection: $event.date,
                displayedComponents: [.date]
            )
            .font(.system(size: 20))
        }
        
    }
    

    
    var changeSpendingSection: some View {
        Section(header: Text("Event Spending")) {
            TextField("", text: $budgetEntry)
                .onAppear {
                    budgetEntry = String(event.spending)
                }
                .font(.system(size: 20))
        }
        
    }
    
    var setCategorySection: some View {
        Section(header: Text("Event Category")) {
            TextField("New Event", text: $event.category)
                .font(.system(size: 20))
        }
    }
    
    var addMemorySection: some View {
        Section(header: Text("Add/Remove from memories")) {
            Toggle("Add to memories", isOn: $event.isMemory)
        }
    }
}
