class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status
      t.integer :guest_id
      t.string :currency
      t.string :payout_price
      t.string :security_price
      t.string :total_price
      t.string :localized_description
    end
  end
end
