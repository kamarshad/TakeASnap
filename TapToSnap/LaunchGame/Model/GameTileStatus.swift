//
//  GameTileStatus.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/19/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI
import Foundation

enum GameTileStatus {
    case yetToStart
    case didNotMatch
    case matched
    
    var imageName: String {
        switch self {
        case .yetToStart:
            return "tileDefault"
        case .matched:
            return "tileSuccess"
        default:
            return "tileIncorrect"
        }
    }
    
    var borderColor: Color {
        switch self {
        case .didNotMatch:
            return .red
        case .matched:
            return .green
        default:
            return .clear
        }
    }
}


class GameStatus: ObservableObject {
    @Published var isFinished: Bool = false
}

class GameResult: Codable, ObservableObject, Identifiable {
    var name: String
    var timeTaken: Int = 0 // This will get updated once time stope or user complete all the stages which ever happens first.
    var itemCompleted: Int = 0 // This will get updated as user passes the game steps
    var rank: Int = 0
    
    init (with name: String) {
        self.name = name
    }
}

extension GameResult {
    
    var imageName: String {
        return "leaderboardIcon"
    }
    
    var userName: String {
        return "User\(name)"
    }
    
    var message: String {
        var durationString = Constants.emptyString
        let (hours, minutes) = ((timeTaken % Constants.secondInDays) / Constants.secondInHours, (timeTaken % Constants.secondInHours) / Constants.secondInMin)
        if hours > 0 {
            let hoursPlaceHolder = (hours == 1) ? "Hour" : "Hours"
            durationString.append("\(hours) \(hoursPlaceHolder) ")
        }
        if minutes > 0 {
            let minutesPlaceHolder = (minutes == 1) ? "Minute" : "Minutes"
            durationString.append("\(minutes) \(minutesPlaceHolder) ")
        }
        if hours == 0 && minutes == 0 {
            durationString.append("\(Constants.oneMinute) Minute")
        }
        return "finished \(itemCompleted) game items in \(durationString)"
    }
}
