//
//  BarView.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/30.
//

import SwiftUI

struct BarView: View {
    
    var fraction: CGFloat
    var geometry: GeometryProxy
    var spending: String
    
    init(_ fraction: Double, in geometry: GeometryProxy, spending: String) {
        self.fraction = max(CGFloat(fraction), 0.25)
        self.geometry = geometry
        self.spending = spending
    }
    
    var animatableData: Double {
        get { Double(fraction) }
        set { self.fraction = CGFloat(newValue) }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: geometry.size.width * 0.7, height: 30)
                .foregroundColor(Color(red: 255/255, green: 211/255, blue: 245/255, opacity: 1))
                .opacity(1)
            
            ZStack(alignment: .trailing) {
                Capsule()
                    .frame(width: geometry.size.width * fraction * 0.7, height: 30)
                    .foregroundColor(.pink)
                    .opacity(0.75)
                
                Text(spending)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.trailing, 7)
            }
            
            
//
        }
    }
}
//
//struct BarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarView()
//    }
//}
