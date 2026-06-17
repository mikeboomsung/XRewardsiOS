import Foundation

extension Decimal {
    var currencyString: String {
        (self as NSDecimalNumber).doubleValue.formatted(.currency(code: "USD"))
    }

    var percentString: String {
        (self as NSDecimalNumber).doubleValue.formatted(.percent.precision(.fractionLength(2)))
    }
}

extension Int {
    var pointsString: String {
        formatted(.number.grouping(.automatic))
    }
}

extension Date {
    var mediumDate: String {
        formatted(date: .abbreviated, time: .omitted)
    }

    var monthYear: String {
        formatted(.dateTime.month(.wide).year())
    }
}
