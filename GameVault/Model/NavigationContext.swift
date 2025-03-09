/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An observable type that manages attributes of the app's navigation system.
*/

import SwiftUI

@Observable
class NavigationContext {
    var selectedGame: Game?
    var columnVisibility: NavigationSplitViewVisibility
    
    init(selectedGame: Game? = nil,
         columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedGame = selectedGame
        self.columnVisibility = columnVisibility
    }
}
