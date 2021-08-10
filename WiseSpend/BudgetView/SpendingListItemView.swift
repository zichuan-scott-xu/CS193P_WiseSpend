//
//  SpendingListItemView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/29.
//

import SwiftUI

struct SpendingListItemView: View {
    var event: SpendEvent
    
    var body: some View {
        
        
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text(event.name)
                        .fontWeight(.medium)
                        .font(.system(size: 21))
                    Spacer()
                    Text(event.category)
                        .frame(alignment: .trailing)
                        .font(.system(size: 14))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(event.spending))
                        .font(.system(size: 21))
                        .fontWeight(.medium)
                    Spacer()
                    Text(event.date.printDate(showDay: true))
                        .frame(alignment: .trailing)
                        .font(.system(size: 14))
                }
            }

        }
    }
}

//struct SpendingListItemView_Previews: PreviewProvider {
//    static var e = SpendEvent(name: "Name", date: Date(), spending: 0, category: "Default", isMemory: false, id: 0)
//    static var previews: some View {
//        SpendingListItemView(event: e)
//    }
// }

