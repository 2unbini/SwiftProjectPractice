//
//  Header.swift
//  MonthlyCalendar
//
//  Created by 권은빈 on 2022/04/10.
//

import SwiftUI

struct Header: View {
    
    @Binding var currentMonth: Int
    
    var body: some View {
        VStack {
            segues
            days
        }
    }
    
    /// 년, 월과 월 단위로 움직일 수 있는 버튼이 있는 뷰
    var segues: some View {
        HStack {
            VStack {
                Text("yyyy")
                    .font(.caption)
                Text("MM")
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
}
