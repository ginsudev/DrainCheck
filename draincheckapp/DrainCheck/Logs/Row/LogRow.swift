//
//  LogRow.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct LogRow: View {
    var log: Log
    @State private var showingAlert = false
    
    var body: some View {
        HStack(alignment: .center) {
            StatBox(percentage: log.startPercent, time: log.startTime)
            ResultsBox(gain: gainType(), elapsedTime: log.timeDiff, battery: log.batteryDiff)
            StatBox(percentage: log.endPercent, time: log.endTime)
        }
        .padding(.vertical, 5)
        .onTapGesture {
            showingAlert = true
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(DataHandler.getFormattedDate(fromDate: log.saveDate)),
                message: Text("Start:\nBattery = \(log.startPercent)%\nTime = \(log.startTime)\n\nEnd:\nBattery = \(log.endPercent)%\nTime = \(log.endTime)\n\nOverall:\nBattery change = \(log.batteryDiff)%\nTime difference = \(log.timeDiff)"),
                dismissButton: .cancel(Text("Dismiss"))
            )
        }
    }
    
    private func gainType() -> Gain {
        if log.startPercent == log.endPercent {
            return .none
        } else if log.startPercent > log.endPercent {
            return .decrease
        } else {
            return .increase
        }
    }
}
