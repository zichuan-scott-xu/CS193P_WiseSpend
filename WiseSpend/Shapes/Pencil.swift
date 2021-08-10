//
//  Pencil.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

struct PieRing: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        return p
    }
}
