class AddDefaultToUsersRole < ActiveRecord::Migration

  def up
    change_column :users, :role, :string, default: 'standard'
  end

  def down
    change_column :users, :role, :string, default: nil
  end

end
