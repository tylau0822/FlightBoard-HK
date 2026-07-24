//
//  DatePickerView.swift
//  FlightBoard HK
//
//  Created by KATY LAU on 24/7/2026.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    @State private var workingDate: Date
    
    private var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let now = Date()
        
        let startDate = calendar.date(byAdding: .year, value: -1, to: now) ?? now
        let endDate = calendar.date(byAdding: .year, value: 1, to: now) ?? now
        
        return startDate...endDate
    }
    
    init(selectedDate: Binding<Date>, isPresented: Binding<Bool>) {
        _selectedDate = selectedDate
        _isPresented = isPresented
        _workingDate = State(initialValue: selectedDate.wrappedValue)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }.foregroundStyle(.secondary)
                
                Spacer()
                
                Text("Select Date")
                    .font(.headline)
                
                Spacer()
                
                Button("Done") {
                    selectedDate = workingDate
                    isPresented = false
                }.fontWeight(.bold)
            }.padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            DatePicker("Date", selection: $workingDate, in: dateRange, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding(.horizontal, 12)

        }.presentationDetents([.medium])
    }
}
