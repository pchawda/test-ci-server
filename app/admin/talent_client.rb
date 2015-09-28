ActiveAdmin.register TalentClient, as: "TalentClient" do
  belongs_to :user, :optional => true

  permit_params :first_name, :last_name, :gender, :user_id, :quote, :quoter, :bio, :profile_image
  form do |f|
    f.inputs "TalentClient Details" do
      f.input :user, :as => :select, :collection => User.user.map {|u| [u.full_name, u.id]}, :include_blank => false
      f.input :first_name
      f.input :last_name
      f.input :gender, as: :radio, collection: TalentClient.genders.keys.collect!{|e| [e, e]}
      f.input :quote
      f.input :quoter
      f.input :bio, :as => :ckeditor
      f.input :profile_image
    end
    f.actions
  end

end
