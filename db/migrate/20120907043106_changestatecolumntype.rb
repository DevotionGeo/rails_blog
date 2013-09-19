class Changestatecolumntype < ActiveRecord::Migration
  def up
    change_column :posts, :state, :boolean
  end

  def down
    change_column :posts, :state, :string
  end
end
