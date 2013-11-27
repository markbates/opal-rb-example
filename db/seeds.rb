Todo.destroy_all

todo = Todo.create!(subject: "Buy Milk", body: "Don't forget to buy the milk")
todo.comments.create(name: "Mark", body: "What kind of milk?")
todo.comments.create(name: "Rachel", body: "2% would be great. Thanks.")

todo = Todo.create!(subject: "Mow the lawn", body: "The lawn is in desperate need of mowing, please do it.", completed: true)
todo.comments.create(name: "Mark", body: "I'm on it!")

todo = Todo.create!(subject: "Learn Go", body: "Go is sweet, you should learn it.")
