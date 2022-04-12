//
//  Review.swift
//  MonthlyCalendar
//
//  Created by 권은빈 on 2022/04/10.
//

import SwiftUI

/// 회고 데이터
/// date: 날짜
/// summary: 오늘 하루는 어땠나요?
/// satisfiedReviews, dissatisfiedReviews: 각 만족한, 불만족한 일에 대한 리뷰
struct Retrospective {
    var date: Date
    var summary: Color
    var satisfiedReviews: [Review]
    var dissatisfiedReviews: [Review]
    
    init(
        date: Date = Date(),
        summary: Color = .pink,
        satisfiedReviews: [Review] = [Review](),
        dissatisfiedReviews: [Review] = [Review]()
    ) {
        self.date = date
        self.summary = summary
        self.satisfiedReviews = satisfiedReviews
        self.dissatisfiedReviews = dissatisfiedReviews
    }
}

/// 일에 대한 리뷰
/// todo: 해당 일에 대한 데이터(할 일)
/// hashtags: 해당 일에 대한 해시태그들
struct Review {
    var todo: Todo
    var hashtags: [Hashtag]
}

/// 할 일
/// date: 날짜
/// content: 내용
struct Todo: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var content: String
}

/// 해시태그
/// title: 해시태그 이름
/// count: 해시태그 빈도수
struct Hashtag: Hashable {
//    var id: UUID = UUID()
    var title: String
    var count: Int
}

// Calendar.current.date(byAdding: .day, value: -1, to: Date())!

func makeMockData() -> [Retrospective] {
    [
        Retrospective(
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            summary: Color.summaryLevelOne,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                        content: "SwiftUI"
                    ),
                    hashtags: [
                        Hashtag(title: "#코딩재밌어", count: 5),
                        Hashtag(title: "#스마트폰멀리함", count: 2),
                        Hashtag(title: "#스마트폰멀리함", count: 2)
                    ]
                )
            ],
            dissatisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                        content: "Sketch"
                    ),
                    hashtags: [
                        Hashtag(title: "#디자인어려워", count: 5),
                        Hashtag(title: "#날씨짱좋아", count: 2)
                    ]
                )
            ]
        ),
        Retrospective(
            date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            summary: .summaryLevelTwo,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                        content: "애플 디벨로퍼 아카데미"
                    ),
                    hashtags: [
                        Hashtag(title: "#SwiftUI", count: 5),
                        Hashtag(title: "#즐거운코딩", count: 2)
                    ]
                )
            ],
            dissatisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Date(),
                        content: "책읽기"
                    ),
                    hashtags: [
                        Hashtag(title: "#시간이없어", count: 5)
                    ]
                )
            ]
        ),
        Retrospective(
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            summary: .summaryLevelFive,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                        content: "밥 해먹기"
                    ),
                    hashtags: [
                        Hashtag(title: "#습관만들기", count: 5),
                        Hashtag(title: "#건강한돼지", count: 2)
                    ]
                )
            ],
            dissatisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Date(),
                        content: "물 마시기"
                    ),
                    hashtags: [
                        Hashtag(title: "#외않마셔", count: 5),
                        Hashtag(title: "#물이없어", count: 2)
                    ]
                )
            ]
        )
    ]
}
