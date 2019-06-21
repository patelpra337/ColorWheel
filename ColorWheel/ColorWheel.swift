//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by patelpra on 6/20/19.
//  Copyright © 2019 Pravin Patel. All rights reserved.
//

import UIKit

class ColorWheel: UIControl {
    
    var color: UIColor = .white

    private func color(for location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let dy = location.y - center.y
        let dx = location.x - center.x
        let offset = CGPoint(x: dx / center.x, y: dy / center.y)
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        return UIColor(hue: hue, saturation: saturation, brightness: 0.8, alpha: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        let radius = frame.width / 2.0
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
    }

    override func draw(_ rect: CGRect) {
        for y in stride(from: 0, through: bounds.maxY, by: 1) {
            for x in stride(from: 0, to: bounds.maxX, by: 1) {
                let color = self.color(for: CGPoint(x: x, y: y))
                let pixel = CGRect(x: x , y: y, width: 1, height: 1)
            
                color.set()
            
                UIRectFill(pixel)
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Begin tracking")
        let touchPoint = touch.location(in: self)
        self.color = self.color(for: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        return true

    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("Continue tracking")
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            self.color = self.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
            print("Touch drag inside")
        } else {
            sendActions(for: [.touchDragOutside])
            print("Touch drag outside")
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        print("End tracking")
        defer { super.endTracking(touch, with: event)}
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            self.color = self.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
            print("Touch drag outside")
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        print("Cancel tracking")
        sendActions(for: [.touchCancel])
    }
}
