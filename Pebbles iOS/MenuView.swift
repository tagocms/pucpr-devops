//
//  MenuView.swift
//  Pebbles iOS
//
//  Created by Tiago Camargo Maciel dos Santos on 25/08/26.
//

internal import Combine
import SwiftUI

struct MenuView: View {
    @ObservedObject var playerModel: PlayerModel
    var body: some View {
        VStack {
            Text("Which player are you?")
            Button("1") {
                playerModel.id = 1
            }
            Button("2") {
                playerModel.id = 2
            }
        }
    }
}

class PlayerModel: ObservableObject {
    @Published var id: Int

    init(_ id: Int = 0) {
        self.id = id
    }
}

#Preview {
    MenuView(playerModel: PlayerModel(0))
}
