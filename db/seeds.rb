require 'ffaker'

AdminUser.create!(email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678')

Category.create([{ title: 'Mobile Development' }, { title: 'Web Design' }, { title: 'Photo' }, { title: 'Web Development' }])
materials = ['paper, brick, hardcove', 'paper stocks, glossym', 'lace, slate, sand', 'lace, man-made fibres']
prices = [39.99, 59.99, 25.99, 69.99]

Category.find_each do |category|
  rand(15..30).times do
    book = Book.create(title: FFaker::Book.title,
                       description: FFaker::Lorem.paragraph,
                       published_at: rand(1999..2018),
                       price: prices[rand(0..3)],
                       materials: materials[rand(0..3)],
                       quantity: 100,
                       height: 6.9,
                       width: 5.1,
                       depth: 0.8)
    rand(1..3).times { book.authors << Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }
    category.books << book
  end
end

Coupon.create(code: 'BOOKER', discount: 5.00)
Coupon.create(code: 'LIBRARIAN', discount: 10.00)

Delivery.create(name: 'Delivery Next Day!', duration: '1 day', price: 10)
Delivery.create(name: 'Express', duration: '2 to 5 days', price: 5)
Delivery.create(name: 'By train', duration: '3 to 7 days', price: 1)
