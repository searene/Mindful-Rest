//
//  BottomCard.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

struct BottomCard<Content: View>: View {

    let content: Content
    @Binding var cardDismissed: Bool
    @Binding var cardShown: Bool
    let height: CGFloat

    init(cardShown: Binding<Bool>,
         cardDismissed: Binding<Bool>,
         height: CGFloat,
         @ViewBuilder content: () -> Content) {
            self.height = height
            _cardShown = cardShown
            _cardDismissed = cardDismissed
            self.content = content()
         }
    
    var body: some View {
        ZStack {
            GeometryReader() {_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                self.dismiss()
            }
            
            VStack {
                Spacer()
                
                VStack {
                    
                    content
                }
                .background(Color.white)
                .frame(height: height)
                .offset(y: !cardDismissed && cardShown ? 0 : height)
                .animation(Animation.default.delay(0.2))
                
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func dismiss() {
        cardDismissed.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cardShown.toggle()
        }
    }
}

struct CardContent: View {
    var body: some View {
        Text("hello world")
            .frame(maxWidth: .infinity)
    }
}

struct BottomCard_Previews: PreviewProvider {
    
    @State private static var cardDismissed = false
    @State private static var cardShown = true
    
    static var previews: some View {
        BottomCard(cardShown: $cardShown,
                   cardDismissed: $cardDismissed,
                   height: 50) {
            CardContent()
                .padding()
        }
    }
    
}
