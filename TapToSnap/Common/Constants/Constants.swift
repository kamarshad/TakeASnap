//
//  Constants.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad 10/19/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation
import SwiftUI

struct Constants {
    static let tapToSnap: String = "Tap to Snap"
    static let letsGo = "LET'S GO"
    static let goToLeaderBoard = "LEADERBOARD"
    static let tryAgain = "Tap to try again"
    static let leaderBoardTitle = "Leaderboard"
    static let emptyString = ""
    static let congrats = "Congrats!"
    static let timeOver = "Time Over!"
    static let maxGuestUserAllowed = 5 // as of allowed storing of 5 results
    // NOTE : As of now 24 hours, you can decrease the time for testing point of view.
    static let maxAllowedTime = 24*60*60
    static let secondInDays = 86400
    static let secondInHours = 3600
    static let secondInMin = 60
    static let oneMinute = 1
}

struct StorageConstants {
    static let gameOverKey: String = "gameOver"
    static let referenceDateKey: String = "referenceDate"
    static let pastScores = "pastScores"
}

struct ResourceConstants {
    static let bgImage: String = "bg"
    static let logo: String = "logo"
}

extension Color {
    static var playGameTitleConainerBGColor: Color {
        return Color("textLayerBGColor")
    }
    static var playGameViewBGColor: Color {
        return Color("playGameBGColor")
    }
    static var barBGColor: Color {
        return Color("barBGColor")
    }
    static var darkGrayColor: Color {
       return Color("darkGrayColor")
    }
}

extension Font {
    static var font1: Font {
        return Font.custom("Karla-Regular", size: 48)
    }
    static var font2: Font {
        return Font.custom("Karla-Bold", size: 28)
    }
    static var font3: Font {
        return Font.custom("Karla-Regular", size: 24)
    }
    static var font4: Font {
        return Font.custom("Karla-Bold", size: 14)
    }
}
