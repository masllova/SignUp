//
//  ContentView.swift
//  firebase
//
//  Created by Александра Маслова on 02.02.2023.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    @State private var showHomeView:Bool = false
    
    var body: some View {
        ZStack {
            
            AnimatedBackground().edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 300,height: 200)
                        .foregroundColor(.white.opacity(0.7))
                        .shadow(color: .white, radius: 100)
                    VStack {
                        HStack {
                            Image(systemName: "mail")
                                .foregroundColor(Color("color6"))
                            TextField("email", text: $emailAddress)
                             .textContentType(.emailAddress)
                             .textInputAutocapitalization(.never)
                             .disableAutocorrection(true)
                             .keyboardType(.emailAddress)
                        }.padding(7)
                         .overlay (RoundedRectangle(cornerRadius:7)
                            .stroke(lineWidth:2).foregroundColor(Color("color7")))
                            .padding(.horizontal, 65)
                        
                        HStack{
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("color6"))
                            SecureField("password", text: $password)
                             .textContentType(.password)
                             .keyboardType(.default)
                        }.padding(7)
                         .overlay (RoundedRectangle (cornerRadius: 7).stroke(lineWidth:2)
                            .foregroundColor(Color("color7")))
                            .padding(.horizontal, 65)
                    }.padding(.top)
                }
                ZStack{
                    Capsule ()
                        .frame(width: 170,height: 40)
                        .foregroundColor(.white.opacity(0.5))
                    
                    Button( action: {
                        //first
                        authModel.signUp( emailAddress: emailAddress, password: password)
                        //second
                        if emailAddress.count != 0 && password.count != 0
                        {self.showHomeView.toggle()}
                        //third
                        emailAddress = ""
                        password = ""
                    }
                            ,label: {
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(Color("color6"))
                    }
                    ) .sheet(isPresented: $showHomeView) {HomeView()}
                }
            }
            ZStack{
                Circle()
                    .frame(width: 90)
                    .foregroundColor(Color("color6"))
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .foregroundColor(.white)
            }.padding(.bottom, 250)
        }
        
    }
}



struct AnimatedBackground: View {
    
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color("color6"), Color("color9"), Color("color2"), Color("color7")]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 7).repeatForever())
            .onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 0)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Now your data is stored in my firebase system")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Divider()
            Button(action: {
                self.presentationMode .wrappedValue.dismiss()
            }, label:
                    {Text("Tap to return")
                    .foregroundColor(.red)
                    .font(.title3)
            })
        }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {ContentView().preferredColorScheme(.light)}
}
