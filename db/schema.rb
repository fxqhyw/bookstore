ActiveRecord::Schema.define(version: 2018_07_15_172338) do
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "book_id", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "published_at"
    t.decimal "price", precision: 6, scale: 2
    t.string "materials"
    t.decimal "height", precision: 4, scale: 1
    t.decimal "width", precision: 4, scale: 1
    t.decimal "depth", precision: 4, scale: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
