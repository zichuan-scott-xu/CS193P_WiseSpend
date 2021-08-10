//
//  ButtonModifier.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/30.
//

import SwiftUI

struct CustomButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(Color.pink.opacity(0.3))
                .cornerRadius(15.0)
        }
    }
}
