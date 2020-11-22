//
//  LeaderBoardView.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/31/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI

struct LeaderBoardView: View {
    var results: [GameResult]
    
    var body: some View {
        ZStack {
            VStack {
                Text(Constants.leaderBoardTitle).font(.largeTitle)
                List(results) { result in
                    LeaderBoardCell(result: result)
                }
            }
        }
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeaderBoardView(results: UserDefaults.standard.getPastScores)
                .preferredColorScheme(.light)
        }
    }
}

struct LeaderBoardCell: View {
    var result: GameResult
    
    var body: some View {
        HStack {
            Image(result.imageName)
                .resizable()
                .frame(width: 60.0, height: 60.0)
                .cornerRadius(30)
            VStack(alignment: .leading){
                Text(result.userName)
                    .font(Font.font3)
                    .foregroundColor(Color.playGameViewBGColor)
                Text(result.message)
                    .font(Font.font4)
                    .foregroundColor(Color.playGameViewBGColor)
            }
        }
    }
}
