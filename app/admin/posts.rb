ActiveAdmin.register Post do
form(:html => { :multipart => true }) do |f|
  f.inputs do
    f.input :title
    f.input :description, :input_html => {:class => "ckeditor"}
    f.input :picture, :as => :file
  end
  f.buttons
end

index do
  column :title do |post|
    link_to post.title, admin_post_path(post)
  end

  column :description do |post|
	post.description.html_safe
  end

  column :picture do |post|
	image_tag post.picture.url.to_s
  end
 
 
  default_actions
end

end
