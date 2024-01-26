//
//  Extensions.swift
//  ProApp
//
//  Created by Yan Shvyndikov on 24.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

extension UILabel {
    convenience init(text: String, textColor: UIColor, font: UIFont){
        self.init()
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension Double {
    private func formatValue(_ value: Double, withSymbol: Bool = true) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let trillion = 1_000_000_000_000.0
        let billion = 1_000_000_000.0
        let million = 1_000_000.0

        var formattedValue = ""
        if value >= trillion {
            if let formattedString = numberFormatter.string(from: NSNumber(value: value / trillion)) {
                formattedValue = "\(formattedString)t"
            }
        } else if value >= billion {
            if let formattedString = numberFormatter.string(from: NSNumber(value: value / billion)) {
                formattedValue = "\(formattedString)b"
            }
        } else if value >= million {
            if let formattedString = numberFormatter.string(from: NSNumber(value: value / million)) {
                formattedValue = "\(formattedString)m"
            }
        } else {
            if let formattedString = numberFormatter.string(from: NSNumber(value: value)) {
                formattedValue = formattedString
            }
        }

        formattedValue = formattedValue.replacingOccurrences(of: ",", with: ".")

        return withSymbol ? "$\(formattedValue)" : formattedValue
    }

    func formattedMarketCap() -> String {
        return formatValue(self)
    }

    func formattedMarketCapNoDollar() -> String {
        return formatValue(self, withSymbol: false)
    }
}
