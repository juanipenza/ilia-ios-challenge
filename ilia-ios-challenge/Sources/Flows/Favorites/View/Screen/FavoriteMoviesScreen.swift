//
//  FavoriteMoviesScreen.swift
//  ilia-ios-challenge
//
//  Created by Joao Paulo on 07/04/22.
//

import SwiftUI

struct FavoriteMoviesScreen: View {
    /*
     @INSERÇÃO
     Faltava a adição do view model
     */
    @EnvironmentObject var viewModel: FavoriteMoviesViewModel
    
    var body: some View {
        FavoriteMoviesScreenMainPage()
            .environmentObject(viewModel)
            .onAppear {
                viewModel.loadFavoriteMovies()
            }
    }
}

struct FavoriteMoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesScreen()
    }
}
