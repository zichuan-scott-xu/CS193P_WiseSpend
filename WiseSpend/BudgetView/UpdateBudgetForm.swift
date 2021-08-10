//
//  UpdateBudgetForm.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/29.
//

import SwiftUI

struct UpdateBudgetForm: View {
    
    
    @Binding var budgets: Dictionary<[Int], Double>
    
    @State var budgetEntry = ""
    
    // a Binding to a PresentationMode
    // which lets us dismiss() ourselves if we are isPresented
    @Environment(\.presentationMode) var presentationMode
    
    var monthYear: [Int]
    
    var body: some View {
        VStack {
            finishedButton
            Form {
                Section(header: Text("Update Budget")) {
                    TextField("", text: $budgetEntry)
                }
            }
        }
    }
    
    var finishedButton: some View {
        HStack {
            Spacer()
            Button("Close") {
                if budgetEntry != "" && Double(budgetEntry) != 0 {
                    budgets[monthYear] = Double(budgetEntry)
                }
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding([.top, .horizontal])
    }
}

//struct UpdateBudgetForm_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateBudgetForm()
//    }
//}
