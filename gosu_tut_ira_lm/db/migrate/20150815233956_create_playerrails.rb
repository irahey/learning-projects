class CreatePlayerrails < ActiveRecord::Migration
  def change
    create_table :playerrails do |t|

      t.timestamps null: false
    end
  end
end
