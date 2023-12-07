import Foundation

protocol CalendarProtocolIn {
    
    func getCalendarDate()
    func addNewDate(with date: DateComponents)
    func removeDate(with date: DateComponents)
    func sentData(with array: [DateComponents])
    
}

protocol CalendarProtocolOut {
    
    var updateCalendarData: ([DateComponents]) -> Void { get set }
    
}

final class CalendarViewModel: CalendarProtocolOut {
    
    // MARK: - Open properties
    
    var updateCalendarData: ([DateComponents]) -> Void = { _ in}
    
    // MARK: - Private properties
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private var dateStringArray = [
        "2023-10-26",
        "2023-10-27",
        "2023-10-30",
    ]
    
}

// MARK: - ActiveAccountListProtocolIn

extension CalendarViewModel: CalendarProtocolIn {
    
    func sentData(with array: [DateComponents]) {
        var newArray = [String]()
        
        for element in array {
            newArray.append(dateComponentsToString(dateComponents: element))
        }
        print(newArray)
        print(newArray.count)
        //TODO: post request
//        print(dateStringArray)
    }

    func getCalendarDate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.updateDate()
        }
    }
    
    func addNewDate(with date: DateComponents) {
        let date = dateComponentsToString(dateComponents: date)
        
        dateStringArray.append(date)
        updateDate()
    }
    
    func removeDate(with date: DateComponents) {
        let date = dateComponentsToString(dateComponents: date)
        
        if dateStringArray.contains(date) {
            if let index = self.dateStringArray.firstIndex(of: date) {
                dateStringArray.remove(at: index)
            }
        }

        updateDate()
    }
 
}

// MARK: - Private func

private extension CalendarViewModel {
    
    func convertDateToCalendarFormat(dateStrings: [String]) -> [DateComponents] {
        var dateComponentsArray: [DateComponents] = []
        
        for dateString in dateStrings {
            if let date = dateFormatter.date(from: dateString) {
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                dateComponentsArray.append(dateComponents)
            } else {
                // Handle invalid date strings if necessary
                print("Invalid date string: \(dateString)")
            }
        }
        
        return dateComponentsArray
    }
    
    func dateComponentsToString(dateComponents: DateComponents) -> String {
        guard let date = Calendar.current.date(from: dateComponents) else {
            return "Unrecognised date"
        }
        
        return dateFormatter.string(from: date)
    }
    
    func updateDate() {
        let dateArray = self.convertDateToCalendarFormat(dateStrings: self.dateStringArray)
        self.updateCalendarData(dateArray)
    }
    
}
