require 'ffaker'

User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')

Category.create([{ title: 'Mobile Development' }, { title: 'Web Design' }, { title: 'Photo' }, { title: 'Web Development' }])
materials = ['paper, brick, hardcove', 'paper stocks, glossym', 'lace, slate, sand', 'lace, man-made fibres']
prices = [39.99, 59.99, 25.99, 69.99]

Category.find_each do |category|
  16.times do
    book = Book.create(title: FFaker::Book.title,
                       description: FFaker::Lorem.paragraph,
                       published_at: rand(1999..2018),
                       price: prices[rand(0..3)],
                       materials: materials[rand(0..3)],
                       height: 6.9,
                       width: 5.1,
                       depth: 0.8)
    rand(1..3).times { book.authors << Author.create(name: FFaker::Name.name) }
    category.books << book
  end
end

Coupon.create!(code: 'BOOKER', discount: 5.00)
Coupon.create!(code: 'LIBRARIAN', discount: 10.00)
