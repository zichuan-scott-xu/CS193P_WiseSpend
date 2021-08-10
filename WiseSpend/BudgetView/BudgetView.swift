//
//  BudgetView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var spendingHistoryStore: SpendingHistory
    @EnvironmentObject var userSettingStore: UserSettingViewModel
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var chosenEvent: SpendEvent?
    @State private var editMode: EditMode = .inactive
    
    @State private var showUpdateBudgetWindow = false
    
    @State private var editBudgetText = "Update Budget"
    
    var currentDate: [Int] {
        let now = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        return [month, year]
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in
                withAnimation {
                    editBudgetText = "Delete Budget"
                }
                
            }
            .onEnded { _ in
                withAnimation {
                    editBudgetText = "Update Budget"
                    userSettingStore.removeBudget(month: currentDate[0], year: currentDate[1])
                }
                
            }
    }
    


    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {
                    ZStack {
                        Text("\(String(format: "%.1f", getBudgetPercentage()))%")
                        Arc(startDegree: 0, endDegree: 360 * getBudgetPercentage() / 100)
                            .stroke((getBudgetPercentage() >= 100 ? Color.red : Color.blue),
                                     lineWidth: 10)
                            .animation(.easeInOut(duration: 2))
                            .frame(width: min(geometry.size.width, geometry.size.height) * 0.3, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                    }
                    Spacer()
                    VStack {
                        Text("\(Date.monthYearToString(month: currentDate[0], year: currentDate[1]))")
                            .padding(.bottom, 5)
                        budgetContent
                            .padding(.bottom)
                        Text(editBudgetText)
                            .frame(width: geometry.size.width * 0.4)
                        .gesture(drag)
                        .onTapGesture(count: 1) {
                            showUpdateBudgetWindow = true
                        }
                        .modifier(CustomButtonStyle())
                        .popover(isPresented: $showUpdateBudgetWindow, content: {
                            UpdateBudgetForm(budgets: $userSettingStore.userSetting.budgets, monthYear: currentDate)
                        })
                    }
                }
                .padding()
                NavigationView {
                    List {
                        ForEach(spendingHistoryStore.events.sorted(by: {$0.date > $1.date})) { event in
                            NavigationLink(destination: EventDetailView(event: $spendingHistoryStore.events[event])) {
                                SpendingListItemView(event: event)
                                    .gesture(editMode == .active ? tapItem(event: event) : nil)
                            }
                            
                        }
                        .onDelete { offset in
                            let sorted = spendingHistoryStore.events.sorted(by: {$0.date > $1.date})
                            for i in offset {
                                if let found = spendingHistoryStore.events.firstIndex(where: { $0 == sorted[i] }) {
                                        spendingHistoryStore.events.remove(at: found)
                                    }
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .popover(item: $chosenEvent) { event in
                        EventEditorView(event: $spendingHistoryStore.events[event])
                    }
                    .navigationTitle("History Spending")
                    .toolbar {
                        addEventToolbar
                        ToolbarItem { EditButton() }
                    }
                    .environment(\.editMode, $editMode)
                }.background(Color.white)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding()
    }
    

    
    var budgetContent: some View {
        
        let month = currentDate[0]
        let year = currentDate[1]
        let budget = userSettingStore.getBudget(month: month, year: year)
        
        return (
            Text (
                budget != nil ?
                    "\(String(format: "%.1f", spendingHistoryStore.getSumSpending(month: month, year: year))) / \(String(format: "%.1f", budget!))" :
                "No budget"
            )
        )
        
    }
    
    
    private var addEventToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                spendingHistoryStore.addSpendingEvent(named: "New Event", date: Date(), spending: 0)
                chosenEvent = spendingHistoryStore.events.first
            }, label: {
                Image(systemName: "plus.circle").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
        }
    }
    
    private func getBudgetPercentage() -> Double {
        if userSettingStore.userSetting.budgets[currentDate] == nil {
            return 0
        }
        let sumSpending = spendingHistoryStore.getSumSpending(month: currentDate[0], year: currentDate[1])
        return sumSpending / userSettingStore.userSetting.budgets[currentDate]! * 100
    }
    
    func tapItem(event: SpendEvent) -> some Gesture {
        TapGesture().onEnded {
            chosenEvent = event
        }
    }
    
}




struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}
