//
//  PastView.swift
//  PastView
//
//  Created by 권은빈 on 2022/04/10.
//

import SwiftUI

struct PastView: View {
    
    // MARK: - Properties
    
    /// 목 데이터
    @State private var mockData: [Retrospective] = makeMockData()
    
    /// < > 버튼으로 월별 이동할 때 사용하는 변수
    /// 오늘의 날짜로부터 얼만큼 떨어져 있는 달인지 계산할 때 사용
    @State private var currentMonth: Int = 0
    
    /// 현재 날짜
    /// 월별 이동할 때 날짜 계산하기 위해 사용하는 변수
    @State private var currentDate: Date = Date()
    
    /// 선택된 날짜
    /// 하단 리뷰 창에서 쓰일 마지막으로 선택된 변수
    @State private var selectedDate: Date = Date()
    
    /// 선택된 리뷰
    /// 하단 리뷰 창에서 쓰일 마지막으로 선택된 회고 데이터
    @State private var currentReview: Retrospective?
    
    /// 스크린 사이즈
    private let screenSize = UIScreen.main.bounds
    
    init() {
        _currentReview = State(initialValue: mockData.first(where: { retrospective in
            retrospective.date.isSameAs(date: Date())
        }))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                CalendarView(
                    currentMonth: $currentMonth,
                    currentDate: $currentDate,
                    selectedDate: $selectedDate,
                    currentReview: $currentReview
                )
                Spacer()
                PastReview(
                    selectedDate: selectedDate,
                    currentReview: currentReview
                )
            }
            .padding(.horizontal, 20)
        }
    }
}


struct PastView_Previews: PreviewProvider {
    static var previews: some View {
        PastView()
    }
}
