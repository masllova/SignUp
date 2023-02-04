//
//  MainView.swift
//  firebase
//
//  Created by Александра Маслова on 02.02.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .keyboardType(.default)
            }
            Section {
                Button( action: {authModel.signUp( emailAddress: emailAddress, password: password)},label: {
                    Text("Sign Up").bold()})
            }
        }.navigationTitle("Sign Up")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
