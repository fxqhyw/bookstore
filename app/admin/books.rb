ActiveAdmin.register Book do
  permit_params :category_id, :title, :price, :description, :materials, :height, :weight, :depth, :published_at, images: [], author_ids: [] 

  authors = proc do
    Author.all.map { |author| ["#{author.first_name} #{author.last_name}", author.id] }
  end

  index do
    selectable_column
    column 'Image' do |book|
      image_tag url_for(book.images.first.variant(resize: '50x65!')) if book.images.attached?
    end
    column :category
    column :title
    column('Authors') { |book| authors_list(book) }
    column('Short description') { |book| truncate(book.description, length: 65) }
    column :price
    column { |book| link_to 'View', edit_admin_book_path(book) }
    column { |book| link_to 'Delete', admin_book_path(book), method: :delete, data: { confirm: 'Are you sure ?' } }
  end

  filter :category
  filter :authors, collection: authors
  filter :title
  filter :price
  filter :published_at

  show do
    default_main_content
    panel 'Images' do
      book.images.each do |image|
        span { image_tag url_for(image.variant(resize: '280x350!')) }
      end
    end
  end

  form html: { multipart: true } do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :published_at
      f.input :quantity
      f.input :materials
      f.input :category, as: :select, collection: Category.pluck(:title, :id), include_blank: false
    end

    f.inputs 'Dimension' do
      f.input :height
      f.input :width
      f.input :depth
    end

    f.inputs 'Images' do
      if book.images.any?
        book.images.each do |image|
          span { image_tag url_for(image.variant(resize: '280x350!')) }
          span { link_to 'Delete', delete_image_admin_book_path(image), data: { confirm: 'Are you sure ?' }, method: :delete }
        end
      end
      f.input :images, as: :file, input_html: { multiple: true }, allow_destroy: true
    end

    f.inputs 'Authors' do
      f.input :author_ids, as: :check_boxes, collection: authors.call, label: 'Authors'
    end
    f.actions
  end

  member_action :delete_image, method: :delete do
    ActiveStorage::Blob.find(params[:id]).delete
    ActiveStorage::Attachment.find(params[:id]).purge
    ActiveAdmin::Dependency.rails.redirect_back self, active_admin_root
  end
end
