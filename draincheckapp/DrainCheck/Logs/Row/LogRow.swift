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
                title: Text("Detailed Statistics"),
                message: Text(detailedStats()),
                dismissButton: .cancel(Text("Dismiss"))
            )
        }
    }
    
    private func detailedStats() -> String {
        var sameDates: Bool {
            if let startDate = log.startDate {
                return DataHandler.getFormattedDate(fromDate: startDate) == DataHandler.getFormattedDate(fromDate: log.saveDate)
            }
            
            return true
        }
        
        var startTime: String {
            var str = ""
            if !sameDates {
                str += "\(DataHandler.getFormattedDate(fromDate: log.startDate!)) "
            }
            str += log.startTime
            return str
        }
        
        let startBlock = "Start:\nBattery = \(log.startPercent)%\nTime = \(startTime)"
        
        var endTime: String {
            var str = ""
            if !sameDates {
                str += "\(DataHandler.getFormattedDate(fromDate: log.saveDate)) "
            }
            str += log.endTime
            return str
        }
        
        let endBlock = "End:\nBattery = \(log.endPercent)%\nTime = \(endTime)"
        
        let overallBlock = "Overall:\nBattery difference = \(log.batteryDiff)%\nTime difference = \(log.timeDiff)"
    
        return "\(startBlock)\n\n\(endBlock)\n\n\(overallBlock)"
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
