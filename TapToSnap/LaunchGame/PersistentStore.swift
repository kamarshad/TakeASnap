//
//  PersistentStore.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/31/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var timeTaken: Int {
        get {
            integer(forKey: StorageConstants.referenceDateKey)
        }
        set { setValue(newValue, forKey: StorageConstants.referenceDateKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var canUpdateStorage: Bool {
        // return true to update the storage
        return integer(forKey: StorageConstants.referenceDateKey) == 0 && isGameOver
    }
    
    // Call this function if you want to reset game
    var isGameOver: Bool {
        get { !bool(forKey: StorageConstants.gameOverKey) }
        set {
            setValue(newValue, forKey: StorageConstants.gameOverKey)
        }
    }
    
    // save game results
    func save(_ result: GameResult) {
        let gameResults = [GameResult?](repeating: nil, count: Constants.maxGuestUserAllowed)
        var compacGameResults = gameResults.compactMap { $0 }
        compacGameResults.append(contentsOf: getOldResults)
        compacGameResults.append(result)
        do {
            let data = try JSONEncoder().encode(compacGameResults)
            set(data, forKey: StorageConstants.pastScores)
            print("Saved the data")
        } catch {
            print("Error occured in saving the game results \(error.localizedDescription)")
        }
        synchronize()
    }
    
    var getPastScores: [GameResult] {
        return getOldResults.sorted { $0.itemCompleted > $1.itemCompleted && $0.timeTaken > $1.timeTaken }
    }
    
    private var getOldResults: [GameResult] {
        var gameResults: [GameResult] = []
        guard let gameResultsData = data(forKey: StorageConstants.pastScores) else { return gameResults }
        do {
            gameResults = try JSONDecoder().decode([GameResult].self, from: gameResultsData)
        } catch {
            print("Error occured in reading save game results \(error.localizedDescription)")
        }
        return gameResults
    }
    
    var isPastScoresAvailable: Bool {
        // If any of the dict value is true i.e at least one captured snaped was matched with the item name.
        return getOldResults.contains { $0.itemCompleted > 0 }
    }
    
    // Maintain guest users count
    var getUsersName: String {
        let count = getOldResults.count
        if count > 0 {
            return "\(count + 1)"
        }
        return "\(1)"
    }
    
    func cleanAll() {
        //set(nil, forKey: StorageConstants.pastScores)
        setValue(0,forKey: StorageConstants.referenceDateKey)
        isGameOver = false
    }
}

