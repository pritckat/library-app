class CreateLibraryBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :library_books do |t|
      t.integer :book_id
      t.integer :library_id

      t.timestamps
    end
  end
end
