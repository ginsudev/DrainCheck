//
//  ContentView.swift
//  DrainCheck
//
//  Created by Noah Little on 24/9/2022.
//

import SwiftUI

struct LogList: View {
    @Environment(\.scenePhase) var scenePhase

    @State var logs = DataHandler.fetchSortedLogs()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(logs ?? [LogGroup]()) { group in
                Section(header: Text(group.date)) {
                    ForEach(group.logs) { log in
                        LogRow(log: log)
                    }
                }
            }
            .navigationTitle("DrainCheck")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .onChange(of: scenePhase, perform: { newValue in
            if newValue == .active {
                refreshData()
            }
        })
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Delete logs"),
                message: Text("Are you sure you want to delete all drain logs?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    DataHandler.removeLogs()
                    refreshData()
                }),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
    
    private func refreshData() {
        logs = DataHandler.fetchSortedLogs()
    }
}
