ActiveAdmin.register User do
  index do
  column :name do |user|
    link_to user.name, admin_user_path(user)
  end

  column :email
  column :created_at
 
  default_actions
end


end
