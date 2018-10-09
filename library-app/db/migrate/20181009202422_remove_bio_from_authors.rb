class RemoveBioFromAuthors < ActiveRecord::Migration[5.2]
  def change
    remove_column :authors, :bio
  end
end
