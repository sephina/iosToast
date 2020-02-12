//
//  Toast.swift
//
//  Created by Sephi Nahmias on 12/02/2020.
//

import UIKit

class Toast: NSObject {
    
    static let label = UILabelPadding()
    static let labelMaxWidthPercent: CGFloat = 0.8
    static let labelBottomDistance: CGFloat = 45
    static let textColor = UIColor.white
    static let bgColor = UIColor(white: 0.15, alpha: 0.85)
    static let timeToShow = 4
    static let paddingX: CGFloat = 20
    static let paddingY: CGFloat = 8
    static let font = UIFont.systemFontSize(ofSize: 16)
    
    static func message(_ message: String) {
        if message.isEmpty {
            return
        }
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        label.clipsToBounds = true
        label.backgroundColor = bgColor
        label.textColor = textColor
        label.dx = paddingX
        label.dy = paddingY
        label.font = font
        let screenWidth = window.frame.width
        let labelMaxWidth = labelMaxWidthPercent * screenWidth
        var size = label.sizeThatFits(CGSize(width: labelMaxWidth - 2 * paddingX, height: CGFloat.greatestFiniteMagnitude))
        size.width = size.width + 2 * paddingX
        size.height = size.height + 2 * paddingY
        label.frame.size = size
        label.layer.cornerRadius = size.height / 2
        let x = (window.frame.width - size.width) / 2
        let y = (window.frame.height - size.height - labelBottomDistance)
        label.frame.origin = CGPoint(x: x, y: y)
        label.isUserInteractionEnabled = false
        window.addSubview(label)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeToShow)) {
            label.removeFromSuperview()
        }
    }
}

class UILabelPadding: UILabel {

    var dx: CGFloat = 0
    var dy: CGFloat = 0

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: dx, dy: dy))
    }
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + 2 * dx
        let heigth = superContentSize.height + 2 * dy
        return CGSize(width: width, height: heigth)
    }
}
