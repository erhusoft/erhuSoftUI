//
<<<<<<< HEAD
//  ESFormatUtils.swift
//  erhuSoftUI
//
//  Created by erhusoft on 28/09/25.
//

import Foundation

public struct ESFormatUtils {
    
    // MARK: - Currency
    public static func formatCurrency(_ amount: Double, locale: String = "es_MX", code: String = "MXN") -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    // MARK: - Decimal
    public static func formatDecimal(_ amount: Decimal, fractionDigits: Int = 3, locale: String = "es_MX") -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = fractionDigits
        return formatter.string(from: amount as NSDecimalNumber) ?? "0.000"
    }
    
    // MARK: - Number
    public static func formatNumber(_ number: Double, fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
    
    // MARK: - Percentage
    public static func formatPercentage(_ value: Double, fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "0%"
    }
    
    public static func formatPercentageAuto(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0.00"
        return "\(formatted)%"
    }
    
    // MARK: - Date
    public static func formatDate(_ date: Date, format: String = "dd/MM/yyyy", locale: String = "es_MX") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public static func formatTimeString(_ timeString: String?) -> String {
        guard let timeString else { return "--:--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        if let date = formatter.date(from: timeString) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        return "--:--"
    }
    
    public static func formatDateString(_ dateString: String?) -> String {
        guard let dateString else { return "-" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "es_MX")
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "d MMM yyyy"
            return formatter.string(from: date)
        }
        return "-"
    }
}
=======
//  ESFormatUtils.swift.swift
//  erhuSoftUI
//
//  Created by erhusoft on 25/09/25.
//

>>>>>>> 2751035793a4c86def7a0d48c7540d72d506ff0f
