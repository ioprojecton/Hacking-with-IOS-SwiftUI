//
//  AddBookView.swift
//  BookWorm
//
//  Created by Vahagn Martirosyan on 2021-01-31.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var author = ""
    @State private var title = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of the book", text: $title)
                    TextField("Authors name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres,id:\.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                  RatingView(rating: $rating)
                    
                    TextField("Write a review", text: $review)
                }
                
                Section{
                    Button(action: {
                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre.isEmpty ? "Unknown" : genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        
                        do{
                            try moc.save()
                        }
                        catch{
                            print(error)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Save")
                    })
                }
                
                
            }
            .navigationBarTitle("Add book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
