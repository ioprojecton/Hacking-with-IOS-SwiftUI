//
//  DetailView.swift
//  BookWorm
//
//  Created by Vahagn Martirosyan on 2021-01-31.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showDeleteAlert = false
    
    let book: Book
    var body: some View {
        GeometryReader{geometry in
            VStack{
                ZStack(alignment:.bottomTrailing){
                    Image(book.genre!)
                        .frame(width:geometry.size.width)
                    
                    if book.genre != "Unknown"{
                    Text((book.genre?.uppercased())!)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                    }
                    
                    if book.date != nil{
                        Text(book.date!)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .offset(x: -3, y: 0)
                    }
                }
                
                Text(book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(book.review ?? "No Review")
                    .padding()
                
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
                
                
                
                Spacer()
            }
        }
        .alert(isPresented: $showDeleteAlert, content: {
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete"), action: {
                deleteBook()
            }), secondaryButton: .cancel())
        })
        .navigationBarItems(trailing: Button(action: {
            showDeleteAlert = true
        }, label: {
            Image(systemName: "trash")
        }))
        .navigationBarTitle(Text(book.title ?? "Unknown book"),displayMode: .inline)
    }
    
    func deleteBook(){
        moc.delete(book)
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView{
            DetailView(book: book)
        }
    }
}
