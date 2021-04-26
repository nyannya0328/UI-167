//
//  PulsView.swift
//  UI-167
//
//  Created by にゃんにゃん丸 on 2021/04/25.
//

import SwiftUI

struct PulsView: View {
    
    @State var startAniamtion = false
    @State var pulse1 = false
    @State var pulse2 = false
    @State var foundPeople : [People] = []
    @State var finishAnimation = false
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack{
            
            HStack{
                
                
                Button(action: {
                    
                    present.wrappedValue.dismiss()
                    
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                })
                
                Text (finishAnimation ? "\(peoples.count)People NearBy": "NearBy Search")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                
                
                
                Button(action: VerifyAndAddPeople) {
                    if finishAnimation{
                        
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        
                    }
                    else{
                        
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .animation(.none)
                
            }
            .padding()
            .padding(.top,getSafeArea().top)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
            
            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -5, y: -5)
            
            ZStack{
                
                
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse1 ? 3.3 : 0)
                    .opacity(pulse1 ? 0 : 1)
                
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse2 ? 3.3 : 0)
                    .opacity(pulse2 ? 0 : 1)
                
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 130, height: 130)
                    .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 5, y: 5)
                
                
                
                
                
    
                    
                    
                    Circle()
                        .stroke(Color.blue,lineWidth: 1.4)
                        .frame(width:finishAnimation ? 70 : 30, height: finishAnimation ? 70 : 30)
                        .overlay(
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .opacity(finishAnimation ? 1 : 0)
                            
                            
                        
                        )
                ZStack{
                    
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue,lineWidth: 1.4)
                    
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue,lineWidth: 1.4)
                        .rotationEffect(.init(radians: -180))
                    
                    
                    
                    
                }
                .frame(width: 70, height: 70)
                .rotationEffect(.init(degrees: startAniamtion ? 360 : 0))
                ForEach(foundPeople){people in
                    
                    
                    Image(people.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(4)
                        .background(Color.white.clipShape(Circle()))
                        .offset(people.offset)
                    
                }
                
                
                
            }
            .frame(maxHeight: .infinity)
            
            if finishAnimation{
                
                VStack{
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 50, height: 2)
                        .padding(.vertical,10)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing:15){
                            
                            ForEach(peoples){people in
                                
                                
                                VStack(spacing:15){
                                    
                                    
                                    Image(people.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    Text(people.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Text("Choose")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                            .padding(.vertical,10)
                                            .padding(.horizontal,40)
                                            
                                            .background(Color.red)
                                            .cornerRadius(10)
                                    })
                                    
                                }
                                .padding(.horizontal)
                                
                            }
                            
                            
                        }
                        .padding()
                        .padding(.bottom,getSafeArea().bottom)
                    })
                }
                .background(Color.green.opacity(0.1))
                .transition(.move(edge: .bottom))
            }
            
            
            
            
            
        }
        .ignoresSafeArea()
        .background(Color.black.opacity(0.03).ignoresSafeArea())
        .onAppear(perform: {
            animationView()
        })
        .navigationBarHidden(true)
    }
    
    
    func animationView(){
        
        
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
            
            
            startAniamtion.toggle()
        }
        
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
            
            
            pulse1.toggle()
        }
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            
            withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
                pulse2.toggle()
            }
        }
        
        
        
        
    }
    
    func VerifyAndAddPeople(){
        
        if foundPeople.count < 5{
            
            withAnimation{
                
                var people = peoples[foundPeople.count]
                
                people.offset = firstFiveOffset[foundPeople.count]
                
                
                foundPeople.append(people)
                
                
            }
            
            
        }
        else{
            
            
            withAnimation(.linear){
                
                
                
                
                
                finishAnimation.toggle()
                
                startAniamtion = false
                pulse1 = false
                pulse2 = false
                
                
                
                
            }
            
            
            if !finishAnimation{
                
                
                withAnimation{
                    
                    foundPeople.removeAll()
                    animationView()
                    
                }
            }
            
        }
        
        
        
        
    }
    
}

struct PulsView_Previews: PreviewProvider {
    static var previews: some View {
        PulsView()
    }
}

struct People : Identifiable {
    var id = UUID().uuidString
    var image : String
    var name : String
    var offset : CGSize = CGSize(width: 0, height: 0)
}

var peoples = [
    People(image: "p1", name: "きんぐまる"),
    People(image: "p2", name: "コアラ丸"),
    People(image: "p3", name: "チーこ"),
    People(image: "p4", name: "らいまる"),
    People(image: "p5", name: "こあら"),
]

var firstFiveOffset: [CGSize] = [
    
    CGSize(width: 100, height: 100),
    CGSize(width: -100, height: -100),
    
    CGSize(width: -50, height: 130),
    CGSize(width: 130, height: -50),
    CGSize(width: 100, height: -50),
]

