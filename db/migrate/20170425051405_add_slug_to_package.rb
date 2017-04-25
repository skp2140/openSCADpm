class AddSlugToPackage < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :slug, :string
    add_index :packages, :slug
  end
end
