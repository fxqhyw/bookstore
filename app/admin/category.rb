ActiveAdmin.register Category do
  permit_params :title

  index do
    selectable_column
    column :title
    column do |category|
      (link_to 'Edit', edit_admin_category_path(category)) + ' | ' +
        (link_to 'Delete', admin_category_path(category), method: :delete, data:
         { confirm: "Are you sure ? This action will delete #{category.books.count} of books" })
    end
  end
end
