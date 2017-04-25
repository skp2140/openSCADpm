class AddLinkToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :link, :string
  end
end
