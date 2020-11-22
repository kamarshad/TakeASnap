//
//  GameGridView.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/18/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI

struct PlayGameView: View {
    @ObservedObject var model: GameItemsViewModel
    // Maintain game details
    @State var gameScoreDetails: GameResult = GameResult(with: UserDefaults.standard.getUsersName)
    @State var isGameCompletd: Bool = false
    @State var isGameResultSaved: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color.barBGColor)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
            VStack {
                Text(Constants.tapToSnap)
                    .frame(width: UIScreen.main.bounds.size.width-CGFloat(20), height: 60)
                    .font(Font.font2)
                    .foregroundColor(Color.white)
                    .background(Color.clear)
                    .padding(.top, 30)
            }.padding(.bottom, 10)
            VStack {
                // Vertical ScrollView for the Grid layout
                ScrollView() {
                    // Custom Grid View
                    GridView(columns: 2, list: model.gameItems) { gameItem in
                        GameTileView(model: gameItem) { success in
                            if success {
                                self.gameScoreDetails.itemCompleted += 1
                                self.isGameCompletd = self.gameScoreDetails.itemCompleted == model.gameItems.count
                            }
                        }
                    }
                }
            }
            VStack {
                TimerCountDownView(isGameCompleted: $isGameCompletd) { success, timeLeft  in
                    if success && self.gameScoreDetails.itemCompleted > 0 && !self.isGameResultSaved {
                        self.gameScoreDetails.timeTaken = timeLeft
                        UserDefaults.standard.save(self.gameScoreDetails)
                        self.isGameResultSaved = true
                    }
                }
            }.frame(width: UIScreen.main.bounds.size.width, height: 80)
                .padding(.bottom, 0)
                .edgesIgnoringSafeArea([.leading,.trailing,.top])
                .background(Color.barBGColor)
        } .navigationBarTitle("", displayMode: .large)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .background(Color.playGameViewBGColor.frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    }
}

// 'Content' here is used to store the View you defined in the Block
// 'T' is the object type of your list.

struct GridView <Content: View, T: Hashable>: View {
    private let vPadding: CGFloat = 150
    private let hPadding: CGFloat = 20
    private let columns: Int
    
    // Multi-dimensional array of your list. Modified as per rendering needs.
    private var gameItems: [[T]] = []
    
    // This block you specify in 'UIGrid' is stored here
    private let content: (T) -> Content
    
    // The Magic goes here
    var body: some View {
        VStack {
            ForEach(0 ..< self.gameItems.count, id: \.self) { index  in
                HStack {
                    ForEach(self.gameItems[index], id: \.self) { gameItem in
                        // Your UI defined in the block is called from here.
                        self.content(gameItem)
                            .frame(width: UIScreen.main.bounds.size.width/CGFloat(self.columns) - self.hPadding,
                                   height: UIScreen.main.bounds.size.height/CGFloat(self.gameItems[index].count) - self.vPadding)
                            .background(Color.clear)
                    }
                }.padding(.horizontal, 10)
                    .padding(.vertical, 5)
            }
        }
    }
    
    init(columns: Int, list: [T], @ViewBuilder content:@escaping (T) -> Content) {
        self.columns = columns
        self.content = content
        self.configureList(list)
    }
    
    // configureList(_:) Converts your array into multi-dimensional array.
    private mutating func configureList(_ list: [T]) {
        var column = 0
        var columnIndex = 0
        
        for object in list {
            if columnIndex < self.columns {
                if columnIndex == 0 {
                    self.gameItems.insert([object], at: column)
                    columnIndex += 1
                }else {
                    self.gameItems[column].append(object)
                    columnIndex += 1
                }
            }else {
                column += 1
                self.gameItems.insert([object], at: column)
                columnIndex = 1
            }
        }
    }
}
