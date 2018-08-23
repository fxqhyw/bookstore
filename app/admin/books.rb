ActiveAdmin.register Book do
  permit_params :id, :category_id, :title, :price, :description, :materials, :height, :weight, :depth, :published_at, :active, author_ids: [] 

  authors = proc do
    Author.all.map { |author| ["#{author.first_name} #{author.last_name}", author.id] }
  end

  index do
    selectable_column
    column :id
    column :category
    column :title
    column('Authors') { |book| authors_list(book) }
    column('Description') { |book| truncate(book.description, length: 75) }
    column :price
    column '' do |book|
      (link_to 'Edit', edit_admin_book_path(book)) + ' | ' +
        (link_to 'Delete', admin_book_path(book), method: :delete, data: { confirm: 'Are you sure ?' })
    end
  end

  filter :category
  filter :title
  filter :price
  filter :published_at
  filter :authors, collection: authors

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :category, as: :select, collection:
        Category.pluck(:title, :id), include_blank: false
      f.input :authors, as: :check_boxes, collection: authors, include_blank: false
      f.input :published_at
      f.input :quantity
      f.input :materials
      f.input :height
      f.input :width
      f.input :depth
    end
    f.actions
  end
end
