//
//  RootView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 25/09/2021.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    
    var body: some View {
        switch (rootviewModel.Status) {
        case Status.none:
            LoginIView() //Muestro login
        case Status.register:
            RegisterView()
        case Status.loading:
            LoaderView() //animación del Spinner
        case Status.error(error: let errorString):
            ErrorView(error: errorString)
        case Status.loaded:
            PrincipalView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(RootViewModel())
    }
}
