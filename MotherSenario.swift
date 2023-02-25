//
//  ScinarioLevel2.swift
//  Outers_Game
//
//  Created by Aldanah Alqbbani on 28/07/1444 AH.
//

import Foundation
import SwiftUI
import RealityKit

struct MotherSenario : View {
    @State var TimerOn : Bool = false
    @State var TimerOn2 : Bool = false
    @State var ispressed2 : Bool = false
    @State var ispressed_timer : Bool = false
    @State var countdownTimer = 3
    @State var isActive = false
    @State var timerRunning = true
    @State private var textswitch = false
    
    //   The publish(every:tolerance:on:in:options:) operator creates a Timer.TimerPublisher, which is a ConnectablePublisher. As a result, subscribers don’t receive any values until after a call to connect(). For convenience when working with a single subscriber, the autoconnect() operator performs the connect() call when attached to by the subscriber.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View{
        ZStack{
            ARViewContainer7()
                .ignoresSafeArea()
            if ispressed2{
                
               StartTimer()
            }  else {
                ZStack{
                    Rectangle()
                        .frame(width: 280,height: 300)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .opacity(0.7)
                    Image("Mother")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                        .offset(y:73)
                    VStack{
                        FadeInOutView2(text: "Could you Help Me", startTime: 0.1)
                            .offset(y:-90)
                        FadeInOutView2(text: "Find My Kid TOYS ?", startTime: 1.5)
                            .offset(y:-85)

                        FadeInOutView3(text: "⚠️ Harry Up before He Cries ⚠️", startTime: 4.0)
                            .offset(y:-80)
                            


                    }
                }
                ZStack(){
                    Button{
                        ispressed2 = true
                        
                    }label: {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 30)
                            
                                .frame(width:260,height:60)
                                .foregroundColor(.white)
                                .opacity(0.7)
                            Text("START")
                                .foregroundColor(.black)
                                .font(.system(size: 25, weight: .heavy, design: .rounded))
                            
                        }
                        
                    }
                }.padding(.top,400)
                //            }  else {
                //
                //                ZStack{
                //                    VStack {
                //                        if countdownTimer > 0{
                //
                //                            Text("\(countdownTimer)")
                //                                .padding()
                //                                .onReceive(timer) { _ in
                //                                    if countdownTimer > 0 && timerRunning {
                //                                        countdownTimer -= 1
                //                                    } else {
                //                                        //
                //                                        timerRunning = false
                //                                    }
                //                                }
                //
                //                                .font(Font.custom("RussoOne-Regular", size: 128))
                //                                .foregroundColor(.white)
                //                            //                            For the timer font
                //                                .glowBorder(color: Color(red: 0.345, green: 0.59, blue: 0.878), lineWidth: 5)
                //                        }
                //                        else{
                //                            Text((textswitch ? "  " : "Go "))
                //                                .font(Font.custom("RussoOne-Regular", size: 128))
                //                                .foregroundColor(.white)
                //                            //                            For the timer font
                //                                .glowBorder(color: Color(red: 0.345, green: 0.59, blue: 0.878), lineWidth: 5)
                //
                //
                //
                //                                .onAppear{
                //                                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                //                                        self.textswitch.toggle()
                //
                //                                    }
                
                
                //                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5){
                //                                        withAnimation{
                //                                            self.TimerOn = true
                //                                        }
                //                                }
                
                //                        }
            }
            
        }
    }
}

struct FadeInOutView2: View {
    
    @State var characters: Array<String.Element>
    @State var opacity: Double = 0
    @State var baseTime: Double
    
    init(text: String, startTime: Double) {
        characters = Array(text)
        baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .foregroundColor(.black)
                    .font(.system(size: 23  , weight: .heavy, design: .rounded))
//                    .frame(width: 300 , height: 500)
                    .multilineTextAlignment(.center)
                    .scaleEffect(opacity)
//                    .opacity(opacity)
               
                    .animation(.easeInOut.delay( Double(num) * 0.05 ),
                               value: opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime){
                opacity = 1
            }
        }
//        .onTapGesture {
//            opacity = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//                opacity = 1
//            }
//        }
    }
}


struct FadeInOutView3: View {
    
    @State var characters: Array<String.Element>
    @State var opacity: Double = 0
    @State var baseTime: Double
    
    init(text: String, startTime: Double) {
        characters = Array(text)
        baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .foregroundColor(.blue)
                    .font(.system(size: 16  , weight: .heavy, design: .rounded))
//                    .frame(width: 300 , height: 500)
                    .multilineTextAlignment(.center)
                    .scaleEffect(opacity)
//                    .opacity(opacity)
               
                    .animation(.easeInOut.delay( Double(num) * 0.05 ),
                               value: opacity)
                    .tint(.black)
                    
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime){
                opacity = 1
            }
        }
//        .onTapGesture {
//            opacity = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//                opacity = 1
//            }
//        }
    }
}





struct MotherSenario_Previews: PreviewProvider {
    static var previews: some View {
        MotherSenario()
    }
}
