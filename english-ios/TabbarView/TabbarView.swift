//
//  TabbarView.swift
//  english
//
//  Created by polykuzin on 15/07/2022.
//

import SwiftUI
import EN_Summary

struct TabbarView : View {
    
    @Environment(\.colorScheme)
    private var colorScheme
    
    @State
    private var cartCount : Int = 0
    
    @State
    private var cartTitle : String = "Settings"
    
    @State
    private var selectedTab : TabbarType = .summary
    
    var body : some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    summary.tag(TabbarType.summary)
                    settings.tag(TabbarType.settings)
                }
                HStack(alignment: .bottom, spacing: 0) {
                    TabbarItem(
                        icon: Image(systemName: "list.bullet.circle"),
                        title: "Summary",
                        badgeCount: 1,
                        isSelected: selectedTab ==  .summary,
                        itemWidth: geometry.size.width / 2) {
                            selectedTab = .summary
                        }
                    TabbarItem(
                        icon: Image(systemName: "gearshape"),
                        title: cartTitle,
                        badgeCount: cartCount,
                        isSelected: selectedTab == .settings,
                        itemWidth: geometry.size.width / 2) {
                            selectedTab = .settings
                        }
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    private var summary : some View {
        EN_SummaryView()
            .tabItem {
                Label("Catalog", systemImage: "house")
            }
    }
    
    private var settings : some View {
        EN_SummaryView()
            .tabItem {
                Label("Catalog", systemImage: "house")
            }
    }
}

#if DEBUG
struct TabbarView_Previews : PreviewProvider {
    
    static var previews : some View {
        TabbarView()
    }
}
#endif
