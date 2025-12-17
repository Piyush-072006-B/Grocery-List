//
//  ContentView.swift
//  Grocery List
//
//  Created by students on 17/12/25.
//

import SwiftUI
import SwiftData
struct ContentView: View { // Used to perform CRUD operations
    @Environment(\.modelContext)
    private var modelContext
    @Query private var Items: [Listt]
    @State private var title = ""
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        NavigationStack {
                
                List { ForEach(Items)
                    { list in Text(list.title) .font(.title2)
                            .fontWeight(.light)
                            .padding(.vertical,5)
                            .padding(.horizontal,2)
                            .foregroundColor(.black)
                            .swipeActions(edge: .leading){
                                Button("Done",role: .destructive){
                                    modelContext.delete(list)
                                }
                                
                                
                            }label: {
                                Label("Delete", systemImage: "trash" )
                            }
                    }
 //                   .swipeActions(edge: .leading){
                        Button("Done", systemImage: List.isCompleted == false ?
                               "checkmark.circle":"x.circle"){
                            Ite.isCompleted.toggle()
                        }
                               .tint(Items.isCompleted == false ? .green : .accentColor)
                    }
                }
                
                .navigationTitle("Grocry list")
                .toolbar{
                    
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        Button{
                            isAlertShowing.toggle()
                        } label: {
                            Image(systemName: "carrot.fill")
                                .imageScale(.large)
                        }
                        .alert("Add Items", isPresented:
                                $isAlertShowing){
                            TextField("Enter item name", text:$title)
                            
                            Button("save"){
                                modelContext.insert(Listt(title:title,isCompleted: true))
                                title=""
                            }
                            .disabled(title.isEmpty)
                            Button("cancel", role: .cancel) {}
                        }
                        
                        
                        
                    }
                }
            
        }
            .overlay{
                if Items.isEmpty{
                    ContentUnavailableView("Empty cart", systemImage: "cart.circle",description: Text("Add some items to the shopping list!" ))
                }
            }
        }
    
        
  
}


#Preview("Second List"){
    do{ let container = try!
        ModelContainer(for: Listt.self,configurations:
                        ModelConfiguration(isStoredInMemoryOnly: true) )
        let ctx = container.mainContext
        ctx.insert(Listt(title: "Swift Coding Club.", isCompleted: true))
        ctx.insert(Listt(title: "cherryies" , isCompleted: true))
        ctx.insert(Listt(title: "Peach" , isCompleted: true))
        ctx.insert(Listt(title: "Banana" , isCompleted: true))
        ctx.insert(Listt(title: "Ba" , isCompleted: true))
        
        
        
        return ContentView()
            .modelContainer(container)
    }
}
#Preview("First List") {
    ContentView()
    .modelContainer(for: Listt.self, inMemory: true)
}
