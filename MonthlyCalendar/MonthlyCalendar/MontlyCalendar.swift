//
//  MontlyCalendar.swift
//  MonthlyCalendar
//
//  Created by 권은빈 on 2022/04/10.
//

import SwiftUI

struct MontlyCalendar: View {
    @State private var mockData: [Retrospective] = makeMockData()
    @State private var currentMonth: Int = 0
    @State private var currentDate: Date = Date()
    
    var body: some View {
        VStack {
            header
            days
        }
    }
    
    private var months: [Date] {
        let startDate = DateComponents(year: Interval.start)
        let endDate = DateComponents(year: Interval.end)
        let interval = DateInterval(
            start: calendar.date(from: startDate)!,
            end: calendar.date(from: endDate)!
        )
        
        return Calendar.current.generateDates(
            interval: DateInterval(
                start: calendarConfig.interval.start,
                end: calendarConfig.interval.end.addingTimeInterval(1)
            ),
            dateComponents: DateComponents(day: 1)
        )
    }
    
    /// 상단 바
    var header: some View {
        
        /// 년, 월과 월 단위로 움직일 수 있는 버튼이 있는 뷰
        var segues: some View {
            HStack {
                VStack {
                    Text("\(currentDate.year)")
                        .font(.caption)
                    Text("\(currentDate.month)")
                        .font(.title3)
                }
                Spacer()
                Group {
                    Button {
                        // previous month
                        currentMonth -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Button {
                        // next month
                        currentMonth += 1
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
        }
        
        /// 요일 뷰
        var days: some View {
            let daysInKorean: [String] = ["월", "화", "수", "목", "금", "토", "일"]
            
            return HStack(spacing: 0) {
                ForEach(daysInKorean, id: \.self) { day in
                    Text(day)
                        .bold()
                        .frame(maxWidth: .infinity)
                }
            }
        }
        
        return VStack {
            segues
            days
        }
    }
    
    var days: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(dates(), id: \.self) { day in
              CardView(day: day)
                    .background(
                        Circle()
                            .fill(Color("Pink"))
                            .padding(.horizontal, 8)
                            .opacity(day.isToday ? 1 : 0)
                    )
                    .onTapGesture {
                        currentDate = day
                    }
            }
        }
    }
    
    private func calculateMonth() -> Date {
        Calendar.current.date(
            byAdding: .month,
            value: currentMonth,
            to: Date()
        ) ?? Date()
    }
    
    private func dates() -> [Date] {
        let currentMonth = calculateMonth()
        return currentMonth.allDates()
    }

    @ViewBuilder
    func CardView(day: Date) -> some View {
        
        VStack {
            
            if Calendar.current.isDate(day, equalTo: currentDate, toGranularity: .month) {
                Text("\(day.day)")
                    .font(.title3.bold())
                    .foregroundColor(day.isToday ? .white : .primary)
                    .frame(maxWidth: .infinity)

                Spacer()
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
            
    }
}

extension Date {
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        return formatter
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.day, .month, .year], from: self)
    }
    
    var year: Int {
        self.dateComponents.year ?? -1
    }
    
    var month: Int {
        self.dateComponents.month ?? -1
    }
    
    var day: Int {
        self.dateComponents.day ?? -1
    }
    
    var isToday: Bool {
        let today = self.formatter.string(from: Date())
        let selectedDate = self.formatter.string(from: self)
        return today == selectedDate
    }
    
    func allDates() -> [Date] {
        guard let startDate = Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: self
            )
        ) else { return [] }
        
        guard let range = Calendar.current.range(of: .day, in: .month, for: startDate)
        else { return [] }
        
        
        return range.compactMap{ day -> Date in
            return Calendar.current.date(
                byAdding: .day,
                value: day - 1 ,
                to: startDate
            ) ?? Date()
        }
    }
}

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}
