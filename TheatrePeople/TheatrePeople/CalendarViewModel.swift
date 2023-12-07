import Foundation

protocol CalendarProtocolIn {
    
    func getCalendarDate()
    func addNewDate(with date: Set<DateComponents>)
    func removeDate(with date: DateComponents)
    func sentData()
    
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
    
    //TODO: выбираются через кнопку все даты месяца включая прошедшие? проблема ли это вообще?
    /// что делать с датами прошлых месяцев сохраненных в системе
    ///  можно сделать очищение массива если больше чем (текущий месяц - 3 месяца) если да то удалять
    ///   а по сути эти данные лежат на сервере и это их вопрос, а не мой
    private var dateStringArray: Set<String> = [
//        "2023-12-26",
//        "2023-12-27",
//        "2023-12-30",
    ]
    
}

// MARK: - ActiveAccountListProtocolIn

extension CalendarViewModel: CalendarProtocolIn {
    
    /*
     Можно сделать два массива, один временный, второй подтвержденный и сохранять в подтвержденный масив в какойнибудь Юзер дефолтс после того как нажмем кноку сохранить и отправим на сервер, до этого храним вов ременном массиве
     */
    func sentData() {
        print(#function)
        
        //TODO: post request
        /*
         нужно отправить массив dateStringArray
         */
    }

    func getCalendarDate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.updateDate()
        }
    }
    
    func addNewDate(with date: Set<DateComponents>) {
        for element in date {
            dateStringArray.insert(dateComponentsToString(dateComponents: element))
        }
        
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
    
    func convertDateToCalendarFormat(dateStrings: Set<String>) -> [DateComponents] {
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
