ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  index do
    selectable_column
    column :first_name
    column :last_name
    column { |author| link_to 'Edit', edit_admin_author_path(author) }
    column do |author|
      link_to 'Delete', admin_author_path(author), method: :delete, data: { confirm: 'Are you sure ?' }
    end
  end
end
