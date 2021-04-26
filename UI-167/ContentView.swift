//
//  ContentView.swift
//  UI-167
//
//  Created by にゃんにゃん丸 on 2021/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{

            ScrollHome()
                .navigationTitle("Medium")
        }
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ScrollHome : View {
    
    @State var startOffset : CGFloat = 0
    @State var Scrolloffset : CGFloat = 0
    @State var isScrollTop = false
  
    var body: some View{
        ScrollViewReader {scrollReader in
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing:25){
                    
                    ForEach(1...50,id:\.self){index in
                        
                        HStack(spacing:15){
                            
                            
                            Circle()
                                .fill(Color.pink)
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 15, content: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.primary.opacity(0.3))
                                    .frame(height: 10)
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.green.opacity(0.3))
                                    .frame(height: 8)
                                    .padding(.trailing,100)
                            })
                                
                        }
                        
                    }
                    
                    
                    
                }
                .padding()
                .id("SCROLL_TO_TOP")
                .overlay(
                    GeometryReader{proxy -> Color in
                        
                        DispatchQueue.main.async {
                            if startOffset == 0{
                                
                                self.startOffset = proxy.frame(in: .global).minY
                                
                            }
                            
                            let offset = proxy.frame(in: .global).minY
                            
                            self.Scrolloffset = offset - startOffset
                            print(Scrolloffset)
                        }
                        
                        
                        
                        return Color.clear
                    }
                    .frame(width: 0, height: 0)
                
                
                )
            })
            .overlay(
            
                VStack(spacing:20){
                    
                    
                    
                   
                    NavigationLink(
                        destination: CardView(),
                        label: {
                            
                            Text("Sign in")
                                 .font(.system(size: 20, weight: .bold))
                             .foregroundColor(.black)
                             .padding(.vertical,10)
                             .padding(.horizontal)
                                 .background(Color.white)
                             .clipShape(Capsule())
                             .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                            
                        })
                    
                      
                           
                    
                    
                    
                    Button(action: {
                        
                        
                        withAnimation(.spring()){
                            
                            isScrollTop = true
                            
                            scrollReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                        
                            
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            
                            isScrollTop = false
                            
                            
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                         
                    })
                    .padding(.bottom,getSafeArea().bottom == 0 ? 10 : 0)
                    .opacity(-Scrolloffset > 450 ? 1 : 0)
                    .animation(.easeInOut)
                    
                    
                    .disabled(isScrollTop)
                    
                    
                    
                }
                .padding()
                
                ,alignment: .bottomTrailing
            
        )
        }
        
        
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds

    }
    
    func getSafeArea()->UIEdgeInsets{
        
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
