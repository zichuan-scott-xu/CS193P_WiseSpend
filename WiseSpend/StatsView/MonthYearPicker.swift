//
//  MonthYearPicker.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/30.
//

import SwiftUI

struct MonthYearPicker: View {
    
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    
    var geometry: GeometryProxy
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Update") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.title3)
            }
            .padding()
            
            HStack(alignment: .center) {
                VStack {
                    Text("Year").font(.subheadline)
                        .padding(.vertical)
                    Picker(selection: $selectedYear, label: Text("Year")) {
                        ForEach(2000...2021, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 2 * 0.6)
                    .clipped()
                }
                VStack {
                    Text("Month").font(.subheadline)
                        .padding(.vertical)
                    Picker(selection: $selectedMonth, label: Text("Month")) {
                        ForEach(1...12, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 2 * 0.6)
                    .clipped()
                }
                
            }
            .padding(.horizontal, geometry.size.width * 0.2)
        }
        
    }
}

//struct MonthYearPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthYearPicker()
//    }
//}
