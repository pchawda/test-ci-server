ActiveAdmin.register User, as: "Admin User" do
  permit_params :email, :first_name, :last_name, :password, :password_confirmation, :role

  controller do
    def scoped_collection
      User.admin
    end
  end

  form do |f|
    f.semantic_errors :base
    f.inputs "Admin User" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
      f.hidden_field :role, value: :admin
    end
    f.actions
  end

end
