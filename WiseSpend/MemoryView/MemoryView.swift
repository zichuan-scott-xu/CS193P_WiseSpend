//
//  MemoryView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

struct MemoryView: View {
    
    @EnvironmentObject var spendingHistoryStore: SpendingHistory
    @EnvironmentObject var userSettingStore: UserSettingViewModel
    
    @State private var chosenEvent: SpendEvent?
    @State private var editMode: EditMode = .inactive
    
    @State private var showUpdateBudgetWindow = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(spendingHistoryStore.allMemories(), id: \.self) { event in
                    NavigationLink(destination: EventDetailView(event: $spendingHistoryStore.events[event])) {
                        SpendingListItemView(event: event)
                    }
                    .gesture(editMode == .active ? tapItem(event: event) : nil)
                }
                .onDelete { offset in
                    for i in offset {
                        if let found = spendingHistoryStore.events.firstIndex(where: { $0 == spendingHistoryStore.allMemories()[i] }) {
                            print(spendingHistoryStore.events[found])
                            spendingHistoryStore.events[found].isMemory = false
                            print(spendingHistoryStore.events[found])
                            }
                        }
                }
            }
            .listStyle(PlainListStyle())
            .popover(item: $chosenEvent) { event in
                EventEditorView(event: $spendingHistoryStore.events[event])
            }
            .navigationTitle("Memories")
            .toolbar {
                ToolbarItem { EditButton() }
            }
            .environment(\.editMode, $editMode)
        }
        .padding()
    }
    
    
    func tapItem(event: SpendEvent) -> some Gesture {
        TapGesture().onEnded {
            chosenEvent = event
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryView()
    }
}
