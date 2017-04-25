class AddPackageInfoToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :package_info, :text
  end
end
