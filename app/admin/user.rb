ActiveAdmin.register User, as: "Users" do
  permit_params :email, :first_name, :last_name, :password, :password_confirmation, :role
  controller do
    def scoped_collection
      User.user
    end
  end

  form do |f|
    f.semantic_errors :base
    f.inputs "User" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  index do
    column :id
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    column :created_at
    column :updated_at
    actions defaults: true do |user|
      link_to "Talent Clients", admin_user_talent_clients_path(user)
    end
  end

end
