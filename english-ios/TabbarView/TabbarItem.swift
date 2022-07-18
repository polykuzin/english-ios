//
//  TabbarItem.swift
//  english-ios
//
//  Created by polykuzin on 15/07/2022.
//

import SwiftUI

struct TabbarItem : View {
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    let icon : Image
    let title : String
    let badgeCount : Int
    let isSelected : Bool
    let itemWidth : CGFloat
    let onTap : () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(alignment: .center, spacing: 2.0) {
                ZStack(alignment: .bottomLeading) {
                    Circle()
                        .foregroundColor(colorScheme == .dark ? .blue : .yellow)
                        .frame(width: 20.0, height: 20.0)
                        .opacity(isSelected ? 1.0 : 0.0)
                    ZStack {
                        icon
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 28.0, height: 28.0)
                            .foregroundColor(isSelected ? (colorScheme == .dark ? .blue : .black) : .gray)
                        Text("\(badgeCount > 99 ? "99+" : "\(badgeCount)")")
                            .kerning(0.3)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(Color.white)
                            .font(.callout)
                            .padding(.horizontal, 4)
                            .background(Color.gray)
                            .cornerRadius(50)
                            .opacity(badgeCount == 0 ? 0.0 : 1.0)
                            .offset(x: 16.0, y: -8.0)
                    }
                }
                Text(title)
                    .font(isSelected ? .caption2 : .caption)
                    .foregroundColor(isSelected ? (colorScheme == .dark ? .blue : .black) : .gray)
            }
            .frame(width: itemWidth)
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
struct TabbarItem_Previews : PreviewProvider {
    
    static var previews: some View {
        TabbarItem(
            icon: Image(systemName: "list.bullet.circle"),
            title: "Summary",
            badgeCount: 1,
            isSelected: true,
            itemWidth: 150,
            onTap: {
                print("TAPPED")
            }
        )
    }
}
#endif
