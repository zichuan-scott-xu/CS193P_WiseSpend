//
//  Arc.swift
//  WiseSpend
//
//  Created by Scott Xu on 2021/5/24.
//

import SwiftUI

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: Double {
        get { endAngle.degrees }
        set { self.endAngle = Angle(degrees: newValue) }
    }
    
    init(startDegree: Double, endDegree: Double, clockwise: Bool = false) {
        self.startAngle = Angle(degrees: startDegree - 90)
        self.endAngle = Angle(degrees: endDegree - 90)
        self.clockwise = clockwise
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}
