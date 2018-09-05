desc 'Counter cache for category has many books'

task book_counter: :environment do
  Category.reset_column_information
  Category.find_each do |b|
    Category.reset_counters b.id, :books
  end
end
