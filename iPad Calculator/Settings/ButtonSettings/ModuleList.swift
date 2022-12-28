//
//  ModuleList.swift
//  iPad Calculator
//
//  Created by Arian Schnappauf on 28.12.22.
//

import Foundation
import SwiftUI

struct ModuleList: View {
    @EnvironmentObject var configuration: ButtonConfiguration
    
    var body: some View {
        NavigationStack {
            List(Array(configuration.modules.enumerated()), id: \.element.id) { (index, element) in
                NavigationLink(value: index){
                    Label(element.name, systemImage: element.icon.rawIcon)
                        .labelStyle(.titleAndIcon)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        if configuration.modules.count > 1 {
                            configuration.modules.remove(at: index)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
            .navigationDestination(for: Int.self) {
                ModuleSettings(for: $configuration.modules[$0])
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        ForEach(ButtonModuleData.templates) { module in
                            Button {
                                var newModule = module
                                newModule.shuffleId()
                                configuration.modules.append(newModule)
                            } label: {
                                Label(module.name, systemImage: module.icon.rawIcon)
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Button Modules")
    }
}
