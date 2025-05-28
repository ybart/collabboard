class AddAuthorIdToPostIts < ActiveRecord::Migration[8.0]
  def change
    add_reference :post_its, :author, foreign_key: { to_table: :users }
  end
end
