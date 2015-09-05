class AddIndexToUsersEmail < ActiveRecord::Migration
  #The migration for enforcing email uniqueness.
  def change
    add_index :users, :email, unique: true
  end
end
