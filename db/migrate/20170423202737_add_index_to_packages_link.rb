class AddIndexToPackagesLink < ActiveRecord::Migration[5.0]
  def change
    add_index :packages, :link, unique: true
  end
end
