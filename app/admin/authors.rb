ActiveAdmin.register Author do
  permit_params :first_name, :last_name

  index do
    selectable_column
    column :first_name
    column :last_name
    column { |author| link_to I18n.t('admin.edit'), edit_admin_author_path(author) }
    column do |author|
      link_to I18n.t('admin.delete'), admin_author_path(author), method: :delete, data: { confirm: I18n.t('admin.sure?') }
    end
  end
end
