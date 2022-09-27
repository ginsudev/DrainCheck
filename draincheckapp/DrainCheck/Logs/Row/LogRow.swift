//
//  LogRow.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct LogRow: View
{
    var log: Log
    @State private var showingAlert = false
    
    var body: some View
    {
        HStack(alignment: .center)
        {
            StatBox(percentage: log.startPercent, time: DataHandler.getFormattedDate(fromDate: log.startDate, withFormatType: .time, localised: true))
            
            ResultsBox(gain: gainType(), elapsedTime: log.timeDiff, battery: log.batteryDiff)
            
            StatBox(percentage: log.endPercent, time: DataHandler.getFormattedDate(fromDate: log.saveDate, withFormatType: .time, localised: true))
        }
        .padding(.vertical, 5)
        
        .onTapGesture
        {
            showingAlert = true
        }
        
        .alert(isPresented: $showingAlert)
        {
            Alert(
                title: Text("Detailed Statistics"),
                message: Text(detailedStats()),
                dismissButton: .cancel(Text("Dismiss"))
            )
        }
    }
    
    private func detailedStats() -> String
    {
        let sameDates = DataHandler.getFormattedDate(fromDate: log.startDate, withFormatType: .date, localised: true) == DataHandler.getFormattedDate(fromDate: log.saveDate, withFormatType: .date, localised: true)
        
        var startTime: String
        {
            var str = ""
            
            if !sameDates
            {
                str += "\(DataHandler.getFormattedDate(fromDate: log.startDate, withFormatType: .date, localised: true)) "
            }
            str += DataHandler.getFormattedDate(fromDate: log.startDate, withFormatType: .timeWithSeconds, localised: true)
            
            return str
        }
        
        let startBlock = "Start:\nBattery = \(log.startPercent)%\nTime = \(startTime)"
        
        var endTime: String
        {
            var str = ""
            
            if !sameDates
            {
                str += "\(DataHandler.getFormattedDate(fromDate: log.saveDate, withFormatType: .date, localised: true)) "
            }
            str += DataHandler.getFormattedDate(fromDate: log.saveDate, withFormatType: .timeWithSeconds, localised: true)
            
            return str
        }
        
        let endBlock = "End:\nBattery = \(log.endPercent)%\nTime = \(endTime)"
        
        var batteryDiffString: String
        {
            let gainType = gainType()
            
            guard gainType != .none else
            {
                return "\(log.batteryDiff)"
            }
            
            return "\(gainType == .increase ? "+" : "-")\(log.batteryDiff)"
        }
        
        let overallBlock = "Overall:\nBattery difference = \(batteryDiffString)%\nTime difference = \(log.timeDiff)"
    
        return "\(startBlock)\n\n\(endBlock)\n\n\(overallBlock)"
    }
    
    private func gainType() -> Gain
    {
        if log.startPercent == log.endPercent
        {
            return .none
        }
        else if log.startPercent > log.endPercent
        {
            return .decrease
        }
        else
        {
            return .increase
        }
    }
}
