//
//  LaunchTapToSnapView.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/18/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI

struct LaunchTapToSnapView: View {
    @ObservedObject var gameItemsViewModel = GameItemsViewModel()

    var body: some View {
        LoaderView(isShowing: .constant(gameItemsViewModel.isLoading)) {
            NavigationView {
                ZStack {
                    Image(ResourceConstants.bgImage)
                        .resizable()
                        .aspectRatio(UIImage(named: ResourceConstants.bgImage)!.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.top)
                        .edgesIgnoringSafeArea(.bottom)
                    VStack {
                        Spacer(minLength: 100)
                        HStack {
                            Image(ResourceConstants.logo)
                        }
                        .padding()
                        .background(Color.clear)
                        .foregroundColor(Color.clear)
                        .cornerRadius(10)
                        VStack {
                            NavigationLink(destination: PlayGameView(model: self.gameItemsViewModel), isActive: self.$gameItemsViewModel.canPush) {
                                Button(action: {
                                    self.gameItemsViewModel.fetchGameItems()
                                }) {
                                    Text(Constants.letsGo)
                                        .font(Font.font2)
                                        .padding(.horizontal, 10)
                                        .frame(minWidth: 0, maxWidth: .infinity,
                                               minHeight: 0,
                                               maxHeight: 50)
                                        .background(Color.pink)
                                }
                            }

                            
                        }.background(Color.white)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 20)
                        Spacer(minLength: 0)
                        VStack{
                            if UserDefaults.standard.isPastScoresAvailable {
                                NavigationLink(destination: LeaderBoardView(results: UserDefaults.standard.getPastScores)) {
                                    Text(Constants.goToLeaderBoard)
                                        .font(Font.font2)
                                        .frame(minWidth: 0, maxWidth: .infinity,
                                               minHeight: 0,
                                               maxHeight: 50)
                                        .background(Color.pink)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .padding([.leading, .trailing], 20)
                                }
                            }
                        }
                        Spacer(minLength: 0)
                    }.padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchTapToSnapView()
    }
}
