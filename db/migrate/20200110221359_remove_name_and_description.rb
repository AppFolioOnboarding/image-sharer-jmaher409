class RemoveNameAndDescription < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :description
    remove_column :images, :name
  end
end
