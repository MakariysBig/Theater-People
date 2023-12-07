import UIKit
import SnapKit
import NetworkKit

final class CalendarViewController: UIViewController {
    
    // MARK: - Internal Dependance
    
    private let viewModel: CalendarViewModel
        
    // MARK: - UI
    
    private let calendarView: UICalendarView = {
        let view = UICalendarView()
        let calendar = Calendar(identifier: .gregorian)
        let futureDate = calendar.date(byAdding: DateComponents(month: 6), to: Date()) ?? Date()
        view.calendar = calendar
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.availableDateRange = DateInterval(start: Date(), end: futureDate)
        return view
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите дни, в которые вы свободны в течении двух месяцев"
        label.numberOfLines = 0
        return label
    }()
    
    private let sentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let selectMonthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выделить все", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
    }()
    
    // MARK: - Initialize
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        getDataFromViewModel()
        listenViewModel()
    }
    
}

// MARK: - Private func
   
private extension CalendarViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        sentButton.addTarget(self, action: #selector(sentButtonWasTapped), for: .touchUpInside)
        selectMonthButton.addTarget(self, action: #selector(selectMonthButtonWasTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        [mainLabel, calendarView, sentButton, selectMonthButton].forEach { view.addSubview($0) }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
        }
        
        sentButton.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(60)
        }
        
        selectMonthButton.snp.makeConstraints {
            $0.top.equalTo(sentButton.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(60)
        }
    }

    func setupSelectedDateToCalendar(date: [DateComponents]) {
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        dateSelection.selectedDates = date
        calendarView.selectionBehavior = dateSelection
    }
    
    func getDate(with component: DateComponents) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(from: component)
        
        return date ?? Date()
    }
    
    @objc
    func sentButtonWasTapped() {
        viewModel.sentData()
    }
    
    
    // TODO: проблема с тем, что месяц выбирается, тот который текущий, а не тот который отображен на экране
    @objc
    func selectMonthButtonWasTapped() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Определите первый и последний день текущего месяца
        
        let firstDayComponents = calendar.dateComponents([.year, .month], from: currentDate)
        guard let firstDay = calendar.date(from: firstDayComponents),
              let lastDay = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDay) else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Формат, который вы хотите отобразить
        dateFormatter.timeZone = TimeZone.current // Используйте текущий часовой пояс
        
        print(dateFormatter.string(from: firstDay))
        print(dateFormatter.string(from: lastDay))
        
        // Включите первый день месяца в массив dateComponentsArray
        var dateComponentsArray: Set<DateComponents> = []
        let components = calendar.dateComponents([.year, .month, .day], from: firstDay)
        dateComponentsArray.insert(components)
        
        calendar.enumerateDates(startingAfter: firstDay, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { (date, _, stop) in
            if let date = date, date <= lastDay {
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                dateComponentsArray.insert(components)
            } else {
                stop = true
            }
        }
        
        viewModel.addNewDate(with: dateComponentsArray)
    }
    
    // MARK: - Binding
    
    func getDataFromViewModel() {
        viewModel.getCalendarDate()
    }
    
    func listenViewModel() {
        viewModel.updateCalendarData = { [weak self] date in
            self?.setupSelectedDateToCalendar(date: date)
        }
    }
    
}

// MARK: - UICalendarSelectionMultiDateDelegate

extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
    
    /// add new date to array
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        let date = getDate(with: dateComponents)
        viewModel.addNewDate(with: [dateComponents])
    }
    
    /// remove date from array
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        let date = getDate(with: dateComponents)
        viewModel.removeDate(with: dateComponents)
    }
 
}
