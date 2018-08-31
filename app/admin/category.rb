ActiveAdmin.register Category, as: 'BookCategory' do
  permit_params :title

  index do
    selectable_column
    column :title
    column { |category| link_to I18n.t('admin.edit'), edit_admin_book_category_path(category) }
    column do |category|
      link_to I18n.t('admin.delete'), admin_book_category_path(category), method: :delete, data:
              { confirm: I18n.t('admin.sure?') + "This action will delete #{category.books.count} of books" }
    end
  end
end
