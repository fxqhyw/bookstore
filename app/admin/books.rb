ActiveAdmin.register Book do
  permit_params :category_id, :title, :price, :description, :materials, :quantity, :height, :width, :depth, :published_at, images: [], author_ids: []
  decorate_with BookDecorator

  authors = proc do
    Author.all.map { |author| ["#{author.first_name} #{author.last_name}", author.id] }
  end

  index do
    selectable_column
    column I18n.t('admin.image') do |book|
      image_tag url_for(book.images.first.variant(resize: '50!x65')) if book.images.attached?
    end
    column :category
    column :title
    column(I18n.t('admin.authors')) { |book| book.authors_list }
    column(I18n.t('admin.short_description')) { |book| truncate(book.description, length: 65) }
    column :price
    column { |book| link_to I18n.t('admin.view'), edit_admin_book_path(book) }
    column { |book| link_to I18n.t('admin.delete'), admin_book_path(book), method: :delete, data: { confirm: I18n.t('admin.sure?') } }
  end

  filter :category
  filter :authors, collection: authors
  filter :title
  filter :price
  filter :published_at

  show do
    default_main_content
    panel I18n.t('admin.images') do
      book.images.each do |image|
        span { image_tag url_for(image.variant(resize: '250!x350')) }
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
      f.input :price
      f.input :category, as: :select, collection: Category.pluck(:title, :id), include_blank: false
    end

    f.inputs I18n.t('admin.dimension') do
      f.input :height
      f.input :width
      f.input :depth
    end

    f.inputs I18n.t('admin.images') do
      unless f.object.new_record?
        book.images.each do |image|
          span { image_tag url_for(image.variant(resize: '250!x350')) }
          span { link_to I18n.t('admin.delete'), delete_image_admin_book_path(image), data: { confirm: I18n.t('admin.sure?') }, method: :delete }
        end
      end
      f.input :images, as: :file, input_html: { multiple: true }, allow_destroy: true
    end

    f.inputs I18n.t('admin.authors') do
      f.input :author_ids, as: :check_boxes, collection: authors.call
    end
    f.actions
  end

  member_action :delete_image, method: :delete do
    ActiveStorage::Blob.find(params[:id]).delete
    ActiveStorage::Attachment.find(params[:id]).purge
    ActiveAdmin::Dependency.rails.redirect_back self, active_admin_root
  end
end
