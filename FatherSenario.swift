//
//  ScinarioLevel2.swift
//  Outers_Game
//



import SwiftUI
import RealityKit
import ARKit
import Vision

struct FatherSenario : View {
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
//            ARViewContainer7()
//                .ignoresSafeArea()
            if ispressed2{
//             CircularTimer()
                StartTimer()
            }  else {
                ARViewContainer7()
                              .ignoresSafeArea()
                ZStack{
                    Rectangle()
                        .frame(width: 280,height: 300)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .opacity(0.7)
                    Image("father")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 250)
                        .offset(y:75)
                    VStack{
                        FadeInOutView(text: "Could you Help Me Find", startTime: 0.1)
                            .offset(y:-88)
                        FadeInOutView(text: "My KEY ?", startTime: 1.5)
                            .offset(y:-85)
//                            .frame(width: 300,height: 100)
                           
                        FadeInOutView(text: "I'm Running Late To work!", startTime: 2.5)
                            .offset(y:-80)
                           
                        FadeInOutView1(text: "⚠️ Be Fast it dispears ⚠️", startTime: 4.0)
                            .offset(y:-77)
                            //here comment
//                        ZStack{
//                            Text("! Warning !")
//
//                                .offset(y:-30)
//                                .foregroundColor(.black)
//                                .font(.system(size: 18 , weight: .heavy, design: .rounded))
//                                .multilineTextAlignment(.center)
//
//                            Text("it's a magical Key Will disapear ")
//
//                                .frame(width: 320,height: 250)
//                                .foregroundColor(.black)
//                                .font(.system(size: 18 , weight: .heavy, design: .rounded))
//                                .multilineTextAlignment(.center)
//                                .offset(y:-10)
//                        }
//
//                        .padding(.top,-70)
//
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
                      
            }
            
        }
    }
}

struct FadeInOutView: View {
    
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
                    .font(.system(size: 20  , weight: .heavy, design: .rounded))
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


struct FadeInOutView1: View {
    
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
                    .font(.system(size: 20  , weight: .heavy, design: .rounded))
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






//    }
//}

struct FatherSenario_Previews : PreviewProvider {
    static var previews: some View {
        FatherSenario()
    }
}
