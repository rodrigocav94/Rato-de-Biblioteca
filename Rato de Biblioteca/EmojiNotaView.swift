//
//  EmojiNotaView.swift
//  Rato de Biblioteca
//
//  Created by Rodrigo Cavalcanti on 13/06/21.
//

import SwiftUI

struct EmojiNotaView: View {
    let nota: Int16

    var body: some View {
        switch nota {
        case 1:
            return Text("âšī¸")
        case 2:
            return Text("đ")
        case 3:
            return Text("đ")
        case 4:
            return Text("đ")
        default:
            return Text("đ")
        }
    }
}

struct EmojiNotaView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiNotaView(nota: 3)
    }
}
