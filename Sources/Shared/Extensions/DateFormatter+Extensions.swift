import Foundation

extension String {
    var dayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else { return "-" }
        let calendar = Calendar.current
        let weekdayComponent = calendar.component(.weekday, from: date)
        return calendar.weekdaySymbols[weekdayComponent - 1]
    }
}
