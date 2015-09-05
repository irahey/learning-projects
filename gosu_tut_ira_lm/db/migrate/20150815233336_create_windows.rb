class CreateWindows < ActiveRecord::Migration
  def change
    create_table :windows do |t|

      t.timestamps null: false
    end
  end
end
