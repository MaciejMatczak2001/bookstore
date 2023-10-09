User.create(email: "admin@gmail.com", password: "123", role: 1)

books = Book.create([
  {
    title: 'Journey to the Center of the Earth',
    price: 10900,
    published: true
  },
  {
    title: 'From the Earth to the Moon',
    price: 6300,
    published: false
  },
  {
    title: 'Imaginary trip',
    price: 3600,
    published: true
  },
])

authors = Author.create([
  {
    first_name: 'Jules',
    last_name: 'Verne'
  },
  {
    first_name: 'Dick',
    last_name: 'Pick',
  },
  {
    first_name: 'Rick',
    last_name: 'Pickle'
  },
])

AuthorsBook.create([
  {
    book: books.first,
    author: authors.first
  },
  {
    book: books[1],
    author: authors.first
  },
  {
    book: books[2],
    author: authors[1]
  },
  {
    book: books[2],
    author: authors[2]
  },
])