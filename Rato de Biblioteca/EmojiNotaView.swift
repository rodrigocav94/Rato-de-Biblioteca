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
            return Text("🔴")
        case 2:
            return Text("🟠")
        case 3:
            return Text("🟡")
        case 4:
            return Text("🟢")
        default:
            return Text("🔵")
        }
    }
}

struct EmojiNotaView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiNotaView(nota: 3)
    }
}
