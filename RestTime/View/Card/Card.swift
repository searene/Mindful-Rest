//
//  Card.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

enum CardPos {
    case middle, bottom
}

struct Card<Content: View>: View {

    let content: Content
    @Binding var cardDismissed: Bool
    @Binding var cardShown: Bool
    var cardPos: CardPos

    init(cardShown: Binding<Bool>,
         cardDismissed: Binding<Bool>,
         cardPos: CardPos,
         @ViewBuilder content: () -> Content) {
            _cardShown = cardShown
            _cardDismissed = cardDismissed
            self.cardPos = cardPos
            self.content = content()
         }
    
    var body: some View {
        ZStack {
            GeometryReader() {_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .onTapGesture {
//                self.dismiss()
            }
            
            if !cardDismissed && cardShown {
                VStack {
                    Spacer()
                    
                    VStack {
                        
                        content
                    }
                    .background(Color.white)
                    
                    if cardPos == .middle {
                        Spacer()
                    }
                }
            }
        }
    }

    private func dismiss() {
        cardDismissed = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cardShown = false
            cardDismissed = false
        }
    }
}

struct CardContent: View {
    var body: some View {
        VStack {
            Button("Modify", action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Button("Delete", role: .destructive, action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Divider()
            
            Button("Cancel", action: {})
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    @State private static var cardDismissed = false
    @State private static var cardShown = true
    
    static var previews: some View {
        TabView {
            Card(cardShown: $cardShown,
                       cardDismissed: $cardDismissed,
                       cardPos: .bottom) {
                CardContent()
                    .padding()
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
            }
        }
    }
    
}
