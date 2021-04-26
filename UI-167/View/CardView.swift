//
//  CardView.swift
//  UI-167
//
//  Created by にゃんにゃん丸 on 2021/04/25.
//

import SwiftUI

struct CardView: View {
    
    
    @State var startAnimation = false
    @State var startCardRote = false
    
    @State var selectedCard : Card = Card(cardHolder: "", cardNumber: "", cardImage: "", cardValidty: "")
    
    
    @State var cardAnimation = false
    @Namespace var animation
    
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollView{
            
            VStack{
                
                
                HStack{
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            
                        
                        Text("Welocm Back")
                            .font(.title)
                            .fontWeight(.bold)
                    })
                    
                
                    
                    
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: PulsView(),
                        label: {
                            
                            Image("p3")
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .frame(width: 50, height: 50)
                              .clipShape(Circle())
                           
                        })
                    
                    
                    
                    
                    
                }
                .foregroundColor(.primary)
                
                ZStack{
                    ForEach(cards.indices,id:\.self){index in
                        
                      
                        CardViewSample(card: cards[index])
                        
                            .scaleEffect(selectedCard.id == cards[index].id ?  1 : index == 0 ? 1 : 0.9)
                            
                            
                            .rotationEffect(.init(degrees:startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                            
                            .onTapGesture {
                                AnimationView(card: cards[index])
                            }
                            
                            
                            .offset(y:startAnimation ? 0 : index == 1 ? 60 : (index == 2 ? -60 : 0))
                            
                            .matchedGeometryEffect(id: "CARD_ANIMATIN", in: animation)
                        
                            .rotationEffect(.init(degrees:selectedCard.id == cards[index].id  && startCardRote ? -90 : 0))
                            .zIndex(selectedCard.id == cards[index].id ? 1000 : 0)
                            .opacity(startAnimation ? selectedCard.id == cards[index].id ? 1 : 0 : 1)
                        
                    }
                    
                    
                }
                .rotationEffect(.init(degrees: 90))
                .frame(height: getRect().width - 30)
                .scaleEffect(0.8)
                .padding(.top,20)
                
                VStack(alignment: .leading, spacing: 15, content: {
                    
                    
                Text("Total Amount Spent")
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    
                    Text("$155,155,155")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        
                    
                    
                    
                })
                .frame(maxWidth: .infinity,alignment: .leading)
                
                
                
            }
            .padding()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.05).ignoresSafeArea())
        .blur(radius: cardAnimation ? 100 : 0)
        .overlay(
        
            ZStack(alignment:.topTrailing){
                
                
                if cardAnimation{
                    
                    
                    Button(action: {
                        
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)){
                            
                            
                            
                            startAnimation = false
                            selectedCard = Card(cardHolder: "", cardNumber: "", cardImage: "", cardValidty: "")
                            cardAnimation = false
                            startAnimation = false
                            
                        }
                        
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(scheme != .dark ? .white : .black)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding()
                    
                    CardViewSample(card: selectedCard)
                        .matchedGeometryEffect(id: "CARD_ANIMATIN", in: animation)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
                    
                }
                
            }
            
            ,alignment: .topTrailing
        
        )
        .navigationBarHidden(true)
        
    }
    
    
    
    func AnimationView(card : Card){
        
        selectedCard = card
        
        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.4)){
            
            
            startAnimation = true
            
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            
            
            
            withAnimation(.spring()){
                startCardRote = true
            
                
            }
            
    
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            
            withAnimation(.spring()){
                
                cardAnimation = true
            }
            
            
        }
        
       
        
        
        
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct CardViewSample : View {
    var card : Card
    var body: some View{
        
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .overlay(
               
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Spacer()
                    
                    Text(card.cardNumber)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: -15, y: -20)
                    Spacer()
                    
                    HStack{
                        
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            
                            
                            Text("CARD HOLDER")
                                .fontWeight(.bold)
                               
                            
                            Text(card.cardHolder)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                        })
                            
                            Spacer(minLength: 10)
                            
                            VStack(alignment: .leading, spacing: 15, content: {
                                Text("CARD VAILD")
                                    .fontWeight(.bold)
                                
                                Text(card.cardValidty)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .kerning(2)
                           
                            
                           
                        })
                        
                        
                        
                    }
                    .foregroundColor(.white)
                    
                    
                    
                })
                .padding()
                
                
            
            )
        
    }
}
