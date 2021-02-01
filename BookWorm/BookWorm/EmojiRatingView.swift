//
//  EmojiRatingView.swift
//  BookWorm
//
//  Created by Vahagn Martirosyan on 2021-01-31.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating:Int16
    var body: some View {
        switch rating {
        case 1:
            return Text("🤍")
        case 2:
            return Text("🖤")
        case 3:
            return Text("💜")
        case 4:
            return Text("🧡")
        default:
            return Text("❤️")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 5)
    }
}
