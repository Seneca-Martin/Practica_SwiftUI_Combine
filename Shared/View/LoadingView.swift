//
//  LoadingView.swift
//  SenecaHeroesMulti
//
//  Created by seneca on 26/09/2021.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var animate = false
    
    var body: some View {
        VStack{
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
                .scaleEffect(animate ? 1.0 :0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Text("Cargando...")
                .foregroundColor(Color.blue)
                .bold()
        }
        .onAppear{
            self.animate = true
        }
        .onDisappear{
            self.animate = false
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
