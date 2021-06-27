class CreateGuest < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.text :phone
    end
    add_index :guests, :email, unique: true
  end
end
