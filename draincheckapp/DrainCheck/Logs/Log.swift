//
//  Log.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import Foundation
import SwiftUI

struct Log: Identifiable
{
    var id = UUID()
    let startPercent: Int
    let endPercent: Int
    let batteryDiff: Int
    let timeDiff: String
    let saveDate: Date
    let startDate: Date
}

struct LogGroup: Identifiable
{
    var id = UUID()
    var logs = [Log]()
    var date: String
}
