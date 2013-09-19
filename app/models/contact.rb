class Contact < ActiveRecord::Base
  attr_accessible :email, :message, :name

  with_options presence: true do |c|
    c.validates :message, :name
    c.validates :email, :email => true
  end
end
