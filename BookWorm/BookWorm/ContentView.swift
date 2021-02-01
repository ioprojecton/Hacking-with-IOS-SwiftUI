//
//  ContentView.swift
//  BookWorm
//
//  Created by Vahagn Martirosyan on 2021-01-31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    

    @FetchRequest(entity: Book.entity(), sortDescriptors: [])
    var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books,id:\.self){ book in
                    NavigationLink(
                        destination: DetailView(book: book),
                        label: {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        })
                    VStack(alignment:.leading){
                        Text(book.title ?? "Unknown title")
                            .font(.headline)
                            .foregroundColor(book.rating < 2 ? .red : .primary)
                        Text(book.author ?? "Unknown author")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteItems(offsets: indexSet)
                })
            }
                .navigationBarTitle("BookWorm")
            .navigationBarItems(leading:EditButton(),trailing: Button(action: {
                    showingAddScreen.toggle()
                }, label: {
                    Image(systemName: "plus")
                }))
                .sheet(isPresented: $showingAddScreen, content: {
                    AddBookView().environment(\.managedObjectContext, moc)
                })
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
