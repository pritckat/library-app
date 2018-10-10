class AddOwnedByToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :owned_by, :integer
  end
end
