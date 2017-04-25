class RemoveUseridFromPackage < ActiveRecord::Migration[5.0]
  def change
    remove_column :packages, :user_id, :string
  end
end
