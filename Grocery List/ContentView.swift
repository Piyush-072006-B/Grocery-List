//
//  ContentView.swift
//  Grocery List
//
//  Created by students on 17/12/25.
import SwiftUI
import SwiftData

struct ContentView: View { // Used to perform CRUD operations
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query private var items: [Listt]
    
    @State private var title: String = ""
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { list in
                    Text(list.title)
                        .font(.title2)
                        .fontWeight(.light)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 2)
                        .foregroundColor(.black)
                        
                        // Delete swipe action
                        .swipeActions(edge: .leading) {
                            Button(role: .destructive) {
                                modelContext.delete(list)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        
                        // Complete / undo swipe action
                        .swipeActions(edge: .trailing) {
                            Button {
                                list.isCompleted.toggle()
                            } label: {
                                Image(systemName: list.isCompleted
                                      ? "x.circle"
                                      : "checkmark.circle")
                            }
                            .tint(list.isCompleted ? .gray : .green)
                        }
                }
            }
            .navigationTitle("Grocry list")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "carrot.fill")
                            .imageScale(.large)
                    }
                    .alert("Add Items", isPresented: $isAlertShowing) {
                        TextField("Enter item name", text: $title)
                        
                        Button("Save") {
                            modelContext.insert(
                                Listt(title: title, isCompleted: true)
                            )
                            title = ""
                        }
                        .disabled(title.isEmpty)
                        
                        Button("Cancel", role: .cancel) { }
                    }
                }
            }
        }
        .overlay {
            if items.isEmpty {
                ContentUnavailableView(
                    "Empty cart",
                    systemImage: "cart.circle",
                    description: Text("Add some items to the shopping list!")
                )
            }
        }
    }
}

#Preview("Second List") {
    let container = try! ModelContainer(
        for: Listt.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let context = container.mainContext
    context.insert(Listt(title: "Swift Coding Club.", isCompleted: true))
    context.insert(Listt(title: "Cherries", isCompleted: true))
    context.insert(Listt(title: "Peach", isCompleted: true))
    context.insert(Listt(title: "Banana", isCompleted: true))
    context.insert(Listt(title: "Ba", isCompleted: true))
    
    return ContentView()
        .modelContainer(container)
}

#Preview("First List") {
    ContentView()
        .modelContainer(for: Listt.self, inMemory: true)
}

