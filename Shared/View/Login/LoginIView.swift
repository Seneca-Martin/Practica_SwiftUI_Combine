//
//  LoginIView.swift
//  SenecaHeroesMulti (iOS)
//
//  Created by seneca on 24/09/2021.
//

import SwiftUI

struct LoginIView: View {
    @EnvironmentObject var rootviewModel: RootViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack() {
            
            Image(decorative: "logo")
                .resizable()
                .scaledToFit()
                .padding([.trailing, .leading], 20)
            
            Spacer()
            
            VStack(){
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Clave", text: self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding([.leading, .trailing], 20) //alineacion izquierda y derecha de 20. por ambos lados.
          
            
            Button(action: {
                // accion del Login
                rootviewModel.login(user: email, password: password)
               
            }) {
                Text("Entrar")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 50)
            
            Spacer()
            
            HStack(spacing: 0) {
                Text("¿No tienes cuenta?")
                Button(action: {
                   //accion del Registro
                    rootviewModel.status = Status.register //Asi cambia la vista
                }) {
                    Text("Registro")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 20)
            
            
        }
        //.background(
            //fondo degradado
            //LinearGradient(gradient: Gradient(colors: [.yellow.opacity(0.2),.orange.opacity(0.8), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
           // .edgesIgnoringSafeArea(.all)
       // )
        
    }
}


struct LoginIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginIView()
            // iniciamos el entorno para diferentes idiomas
            .environment(\.locale, .init(identifier: "es"))
    }
}
