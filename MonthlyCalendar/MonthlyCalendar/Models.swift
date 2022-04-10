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
    var dissatisfiedRevies: [Review]
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
struct Todo {
    var date: Date
    var content: String
}

/// 해시태그
/// title: 해시태그 이름
/// count: 해시태그 빈도수
struct Hashtag {
    var title: String
    var count: Int
}

func makeMockData() -> [Retrospective] {
    [
        Retrospective(
            date: Date(),
            summary: .yellow,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Date(),
                        content: "SwiftUI"
                    ),
                    hashtags: [
                        Hashtag(title: "#코딩재밌어", count: 5),
                        Hashtag(title: "#스마트폰멀리함", count: 2)
                    ]
                )
            ],
            dissatisfiedRevies: [
                Review(
                    todo: Todo(
                        date: Date(),
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
            summary: .yellow,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                        content: "SwiftUI"
                    ),
                    hashtags: [
                        Hashtag(title: "#코딩재밌어", count: 5),
                        Hashtag(title: "#스마트폰멀리함", count: 2)
                    ]
                )
            ],
            dissatisfiedRevies: [
                Review(
                    todo: Todo(
                        date: Date(),
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
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            summary: .yellow,
            satisfiedReviews: [
                Review(
                    todo: Todo(
                        date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
                        content: "SwiftUI"
                    ),
                    hashtags: [
                        Hashtag(title: "#코딩재밌어", count: 5),
                        Hashtag(title: "#스마트폰멀리함", count: 2)
                    ]
                )
            ],
            dissatisfiedRevies: [
                Review(
                    todo: Todo(
                        date: Date(),
                        content: "Sketch"
                    ),
                    hashtags: [
                        Hashtag(title: "#디자인어려워", count: 5),
                        Hashtag(title: "#날씨짱좋아", count: 2)
                    ]
                )
            ]
        )
    ]
}
