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
    @Binding var cardShown: Bool
    var cardPos: CardPos
    let tapElsewhereToDismiss: Bool

    init(cardShown: Binding<Bool>,
         cardPos: CardPos,
         tapElsewhereToDismiss: Bool,
         @ViewBuilder content: () -> Content) {
            _cardShown = cardShown
            self.cardPos = cardPos
            self.tapElsewhereToDismiss = tapElsewhereToDismiss
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
                if tapElsewhereToDismiss {
                    self.dismiss()
                }
            }
            
            if cardShown {
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
        withAnimation {
            cardShown = false
        }
    }
}

struct CardContent: View {
    
    private let MODIFY: LocalizedStringKey = "Modify"
    private let DELETE: LocalizedStringKey = "Delete"
    private let CANCEL: LocalizedStringKey = "Cancel"
    
    var body: some View {
        VStack {
            Button(MODIFY, action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Button(DELETE, role: .destructive, action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Divider()
            
            Button(CANCEL, action: {})
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct Card_Previews: PreviewProvider {
    
    @State private static var cardShown = true
    
    private static let counter: LocalizedStringKey = "Counter"
    
    static var previews: some View {
        TabView {
            Card(cardShown: $cardShown,
                       cardPos: .bottom,
                       tapElsewhereToDismiss: true) {
                CardContent()
                    .padding()
            }
            .tabItem {
                Label(counter, systemImage: "list.dash")
            }
        }
    }
    
}
