//
//  PastReview.swift
//  MonthlyCalendar
//
//  Created by Eunbin Kwon on 2022/04/12.
//

import SwiftUI

struct PastReview: View {
    
    var selectedDate: Date
    var currentReview: Retrospective?
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                // 상단 날짜, 편집 버튼
                HStack {
                    Text("\(selectedDate.compactString)")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    Button {
                        // TODO: 회고 창 열기
                        print("open review modal view")
                    } label: {
                        Text("편집")
                    }
                }
                .foregroundColor(.customBlack)
                .padding([.top, .horizontal], 20)
                
                // 하단 스크롤 가능한 내용 창
                ScrollView(.vertical) {
                    if let currentReview = currentReview {
                        reviewStack(with: currentReview, in: proxy, hasSatisfied: true)
                        reviewStack(with: currentReview, in: proxy, hasSatisfied: false)
                    } else {
                        Text("작성된 회고가 없습니다.")
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                    }
                }
            }
            .background(.white)
            .cornerRadius(10)
        }
    }
    
    private func reviewStack(with currentReview: Retrospective, in proxy: GeometryProxy, hasSatisfied: Bool) -> some View {
            // TODO: Section Image 교체
            let sectionImage: Image = hasSatisfied ? Image(systemName: "square") : Image(systemName: "square.fill")
            let sectionTitle: String = hasSatisfied ? "만족카도" : "불만족카도"
            
            return HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        sectionImage
                        Text(sectionTitle)
                            .font(.callout.bold())
                            .foregroundColor(.customBlack)
                    }
                    .padding(.bottom, 13)
                    contentsView(retrospective: currentReview, proxy: proxy, hasSatisfied: hasSatisfied)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
    }
    
    /// 리뷰 내용을 보여주는 화면
    private func contentsView(retrospective: Retrospective, proxy: GeometryProxy, hasSatisfied: Bool) -> some View {
        var reviews: [Review] = []
        
        if hasSatisfied {
            reviews = retrospective.satisfiedReviews
        } else {
            reviews = retrospective.dissatisfiedReviews
        }
        
        return ForEach(0..<reviews.count, id: \.self) { index in
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Image(systemName: "circle")
                    Text(reviews[index].todo.content)
                        .foregroundColor(.customBlack)
                }
                makeHashtagView(hashtags: reviews[index].hashtags, proxy: proxy)
                    .padding(.leading, 25)
            }
        }
    }
    
    private func tag(title: String) -> some View {
        Text(title)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .foregroundColor(Color.customBlack)
            .background(Color.hashtagBackground)
            .cornerRadius(10)
    }
    
    private func makeHashtagView(hashtags: [Hashtag], proxy: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(hashtags, id: \.self) { hashtag in
                tag(title: hashtag.title)
                    .padding([.trailing, .bottom], 8)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > proxy.size.width {
                            width = 0
                            height -= dimension.height
                        }
                        
                        let result = width
                        
                        if hashtag == hashtags.last! {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        
                        if hashtag == hashtags.last! {
                            height = 0
                        }
                        
                        return result
                    }
            }
        }
    }
}
