//
//  CalendarView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct CalendarView: View{
    @Binding var visitDate: Date
    
    var body: some View{
        DatePicker(selection: $visitDate, in: Date()..., displayedComponents: .date) {
        }
        .onChange(of: visitDate) { _ in
            
        }
        .datePickerStyle(GraphicalDatePickerStyle())
        .accentColor(Color("Primary"))
        .clipped()
        .labelsHidden()
        .padding(.horizontal)
    }
}
