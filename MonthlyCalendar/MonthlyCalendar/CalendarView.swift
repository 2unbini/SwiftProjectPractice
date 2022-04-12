//
//  CalendarView.swift
//  MonthlyCalendar
//
//  Created by Eunbin Kwon on 2022/04/12.
//

import SwiftUI

struct CalendarView: View {
    
    /// < > 버튼으로 월별 이동할 때 사용하는 변수
    /// 오늘의 날짜로부터 얼만큼 떨어져 있는 달인지 계산할 때 사용
    @Binding var currentMonth: Int
    
    /// 현재 날짜
    /// 월별 이동할 때 날짜 계산하기 위해 사용하는 변수
    @Binding var currentDate: Date
    
    /// 선택된 날짜
    /// 하단 리뷰 창에서 쓰일 마지막으로 선택된 변수
    @Binding var selectedDate: Date
    
    /// 선택된 리뷰
    /// 하단 리뷰 창에서 쓰일 마지막으로 선택된 회고 데이터
    @Binding var currentReview: Retrospective?
    
    /// 목 데이터
    private let mockData: [Retrospective] = makeMockData()
    
    /// 스크린 사이즈
    private let screenSize = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            header
            dates
        }
        .frame(width: screenSize.width * 0.85, height: screenSize.height * 0.38, alignment: .top)
        .padding(.all, 10)
        .background(.white)
        .cornerRadius(10)
    }
    
    
    // MARK: - View Property
    
    /// 상단 바
    var header: some View {
        
        /// 년, 월과 월 단위로 움직일 수 있는 버튼이 있는 뷰
        var segues: some View {
            HStack {
                HStack(alignment: .bottom, spacing: 5) {
                    Text("\(currentDate.month)월")
                    Text(String(currentDate.year))
                }
                .foregroundColor(.customBlack)
                .font(.system(size: 17, weight: .semibold))
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
                .foregroundColor(Color.customBlack)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 15)
            .onChange(
                of: currentMonth) { newValue in
                    self.currentDate = calculateMonth()
                }
        }
        
        /// 요일 나타내는 바
        var weekdaySymbols: some View {
            let daysInKorean: [String] = ["일", "월", "화", "수", "목", "금", "토"]
            
            return HStack(spacing: 0) {
                ForEach(daysInKorean, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        
        return VStack {
            segues
            weekdaySymbols
        }
        .padding(.top, 20)
    }
    
    /// 날짜 뷰
    var dates: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        let dates = generateDates()
        
        return LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<dates.count, id: \.self) { index in
                if let day = dates[index] {
                    dateView(day: day)
                        .onTapGesture {
                            currentDate = day
                            selectedDate = day
                            currentReview = mockData.first(where: { retrospective in
                                retrospective.date.isSameAs(date: currentDate)
                            })
                        }
                } else {
                    dateView(day: Date())
                        .hidden()
                }
            }
        }
    }
    
    
    // MARK: - Functions
    
    /// 늘어난 혹은 줄어든 숫자에 따라 달 계산
    private func calculateMonth() -> Date {
        Calendar.current.date(
            byAdding: .month,
            value: self.currentMonth,
            to: Date()
        ) ?? Date()
    }
    
    /// 해당하는 달에 대한 일자 계산
    private func generateDates() -> [Date?] {
        let currentMonth = calculateMonth()
        var days: [Date?] = currentMonth.allDates()
        
        // 이 달에 해당되지 않는 날짜만큼 nil 추가
        let firstDayOfMonth = Calendar.current.component(
            .weekday,
            from: (days.first ?? Date()) ?? Date()
        )
        
        for _ in 0..<(firstDayOfMonth - 1) {
            days.insert(nil, at: 0)
        }
        
        return days
    }

    
    // MARK: - ViewBuilder
    
    /// 각 날짜 한 칸을 그리는 뷰
    @ViewBuilder
    func dateView(day: Date) -> some View {
        
        if let retrospective = mockData.first(where: { retrospective in
            retrospective.date.isSameAs(date: day)
        }) {
            ZStack {
                Circle()
                    .fill(retrospective.summary)
                    .opacity(day.isToday ? 1 : 0.5)
                Circle()
                    .strokeBorder(day.isToday ? Color.customBlack : .clear, lineWidth: 2)
                    .opacity(day.isSameAs(date: selectedDate) ? 1 : 0.6)
                // TODO: 색깔에 따라 글자색 다름
                Text("\(day.day)")
                    .foregroundColor(Color.customBlack)
                    .opacity(day.isSameAs(date: selectedDate) ? 1 : 0.45)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
            }
        } else {
            Text("\(day.day)")
                .foregroundColor(Color.customBlack)
                .opacity(day.isSameAs(date: selectedDate) ? 1 : 0.45)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
        }
    }
}
