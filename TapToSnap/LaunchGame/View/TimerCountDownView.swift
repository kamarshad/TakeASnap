//
//  TimerCountDownView.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/18/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI
import Combine

struct TimerCountDownView: View {
    private let calender = Calendar(identifier: .gregorian)
    private let formatter = DateFormatter()
    @Binding var isGameCompleted: Bool
    @State private var timer: Timer?
    @State private var nowDate: Date = Date()
    @State private var referenceDate = UserDefaults.standard.timeTaken > 0 ? UserDefaults.standard.timeTaken : Constants.maxAllowedTime
    
    var completionBlock: (_ success: Bool, _ lapsedTime: Int) -> Void

    func configureTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.referenceDate > 0 {
                self.referenceDate -= 1
                UserDefaults.standard.timeTaken = self.referenceDate
                self.nowDate = Date()
            } else {
                timer.invalidate()
                updateTimerCountDown()
            }
        }
    }
    
    private func updateTimerCountDown() {
        self.timer?.invalidate()
        UserDefaults.standard.isGameOver = true
        completionBlock(true, self.referenceDate)
        UserDefaults.standard.timeTaken = 0
    }
    
    private func countDownString(from time: Int, until nowDate: Date) -> String {
        let fromDate = Date(timeIntervalSinceNow: TimeInterval(time))
        let components = calender.dateComponents([.hour, .minute, .second], from: nowDate, to: fromDate)
        if isGameCompleted {
            self.updateTimerCountDown()
            UserDefaults.standard.isGameOver = true
            return Constants.congrats
        }
        if components.hour == 0 && components.minute == 0 && components.second == 0 {
            self.updateTimerCountDown()
            return Constants.timeOver
        }
        return String(format: "%02d:%02d:%02d",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
        
    var body: some View {
        Text(countDownString(from: referenceDate, until: nowDate))
            .font(.font2)
            .foregroundColor(Color.white)
            .onAppear(perform: {
                if  UserDefaults.standard.canUpdateStorage {
                    UserDefaults.standard.timeTaken = Constants.maxAllowedTime
                    self.referenceDate = Constants.maxAllowedTime
                }
                configureTimer()
            })
    }
}
