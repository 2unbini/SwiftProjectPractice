//
//  PastView.swift
//  PastView
//
//  Created by 권은빈 on 2022/04/10.
//

import SwiftUI

struct PastView: View {
    
    // MARK: - Properties
    
    @State private var mockData: [Retrospective] = makeMockData()
    @State private var currentMonth: Int = 0
    @State private var currentDate: Date = Date()
    @State private var currentReview: Retrospective?
    private let screenSize = UIScreen.main.bounds
    
    init() {
        _currentReview = State(initialValue: mockData.first(where: { retrospective in
            retrospective.date.isSameAs(date: Date())
        }))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                calendar
                Spacer()
                review
            }
        }
    }
    
    
    // MARK: - View
    
    /// 캘린더
    var calendar: some View {
        Rectangle()
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .foregroundColor(.white)
            .frame(width: screenSize.width, height: screenSize.height * 0.45, alignment: .top)
            .overlay(alignment: .top, content: {
                VStack {
                    header
                    dates
                }
                .padding(.all, 20)
                .frame(width: screenSize.width, height: screenSize.height * 0.4, alignment: .top)
            })
        
    }
    
    /// 상단 바
    var header: some View {
        
        /// 년, 월과 월 단위로 움직일 수 있는 버튼이 있는 뷰
        var segues: some View {
            HStack {
                HStack(alignment: .bottom, spacing: 5) {
                    Text("\(currentDate.month)월")
                    Text(String(currentDate.year))
                }
                .font(.callout.bold())
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
    }
    
    var dates: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        let dates = generateDates()
        
        return LazyVGrid(columns: columns, spacing: 15) {
            ForEach(0..<dates.count, id: \.self) { index in
                if let day = dates[index] {
                    dateView(day: day)
                        .onTapGesture {
                            currentDate = day
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

    
    // MARK: - ViewBuilder, View Functions
    
    /// 각 날짜를 그리는 뷰
    @ViewBuilder
    func dateView(day: Date) -> some View {
        
        if let retrospective = mockData.first(where: { retrospective in
            retrospective.date.isSameAs(date: day)
        }) {
            ZStack {
                Circle()
                    .fill(retrospective.summary)
                Text("\(day.day)")
                    .font(.system(size: 17, weight: day.isToday ? .bold : .regular))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 9)
            }
        } else {
            Text("\(day.day)")
                .font(.system(size: 17, weight: day.isToday ? .bold : .regular))
                .foregroundColor(day.isToday ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
        }
    }
    
    /// 회고 뷰
    @ViewBuilder
    var review: some View {
        if let currentReview = currentReview {
            ScrollView(.vertical) {
                Group {
                    Text("만족한 일")
                    contentsView(retrospective: currentReview, hasSatisfied: true)
                }
                Group {
                    Text("불만족한 일")
                    contentsView(retrospective: currentReview, hasSatisfied: false)
                }
            }
        } else {
            VStack(alignment: .center) {
                Text("작성된 회고가 없습니다.")
                Spacer()
            }
        }
    }
    
    func contentsView(retrospective: Retrospective, hasSatisfied: Bool) -> some View {
        var reviews: [Review] = []
        
        if hasSatisfied {
            reviews = retrospective.satisfiedReviews
        } else {
            reviews = retrospective.dissatisfiedReviews
        }
        
        return ForEach(0..<reviews.count, id: \.self) { index in
            VStack {
                Text(reviews[index].todo.content)
                HStack(spacing: 5) {
                    ForEach(reviews[index].hashtags, id: \.self) { hashtag in
                        Text(hashtag.title)
                    }
                }
            }
        }
    }
}

