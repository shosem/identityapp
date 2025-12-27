class AddDeletedToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :deleted, :boolean, default: false, null: false
  end
end
