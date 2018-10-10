class AddLoanedToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :loaned, :boolean, default: 0
    add_column :books, :loaned_to, :integer
  end
end
