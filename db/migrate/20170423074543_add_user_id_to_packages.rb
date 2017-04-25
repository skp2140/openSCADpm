class AddUserIdToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :user_id, :integer
    add_index :packages, :user_id
  end
end
