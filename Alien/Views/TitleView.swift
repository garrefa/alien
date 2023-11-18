// Copyright © 2023 Area51 Brasil. All rights reserved.

import SwiftUI

struct TitleView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        HStack(spacing: 0) {
            AlienView()
                .zIndex(100)
            if isDarkMode {
                DarkWlltView()
                    .offset(x: -9, y: 3)
            } else {
                LightWlltView()
                    .offset(x: -9, y: 1)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct AlienView: View {
    var body: some View {
        Text("alien")
            .font(.system(size: 56))
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(
                Color.accentColor.shadow(
                    .drop(
                        color: .glow.opacity(0.8),
                        radius: 2, x: 2, y: 2)
                )
            )
    }
}

struct DarkWlltView: View {
    var body: some View {
        Text("wllt")
            .font(.system(size: 56))
            .fontWeight(.heavy)
            .fontDesign(.rounded)
            .foregroundStyle(
                Color.background.shadow(
                    .inner(
                        color: .glow.opacity(0.4),
                        radius: 5, x: 2, y: 2)
                ).shadow(.inner(
                    color: .inverse.opacity(0.1), //black 0.6
                    radius: 1, x: -1, y: -1)
                )
            )
    }
}

struct LightWlltView: View {
    var body: some View {
            ZStack {
                Text("wllt")
                    .offset(x:  1, y:  1)
                    .font(.system(size: 56))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundColor(.glow)

                Text("wllt")
                    .font(.system(size: 56))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(
                        Color.background.shadow(
                            .inner(
                                color: .inverse.opacity(0.2),
                                radius: 2, x: 1, y: 1))
                    )
            }
    }
}

#if DEBUG
struct TitleView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                Text("Welcome!")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            TitleView()
                        }
                    }
            }
        }
    }
}
#endif
