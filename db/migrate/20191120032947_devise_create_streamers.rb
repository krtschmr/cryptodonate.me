# frozen_string_literal: true

class DeviseCreateStreamers < ActiveRecord::Migration[6.0]
  def change
    create_table :streamers do |t|
      t.string :uuid, null: false
      # identify the user
      t.string :provider, null: false, index: true
      t.string :uid, null: false, index: true

      ## Rememberable
      t.datetime :remember_created_at

      t.string :donation_url


      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :name, null: false
      t.string :email, null: false
      t.string :description
      t.string :url

      t.string :token
      t.string :refresh_token

      t.string :profile_photo_url

      t.timestamps null: false
    end
    add_index :streamers, [:provider, :uid], unique: true
  end
end
