class CreateDonationSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :donation_settings do |t|
      t.belongs_to :streamer
      t.string :converted_currency, default: "USD"
      t.decimal :minimum_amount_for_notification, precision: 6, scale: 2, default: 1.0
      t.timestamps
    end
  end
end
