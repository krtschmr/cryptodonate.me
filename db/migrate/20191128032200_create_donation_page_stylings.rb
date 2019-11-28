class CreateDonationPageStylings < ActiveRecord::Migration[6.0]
  def change
    create_table :donation_page_stylings do |t|
      t.belongs_to :streamer

      t.string :bg, default: "#eff1f4";
      t.string :header_bg, default: "#122332";
      t.string :photo_border_color, default: "#fff";
      t.string :h1_color, default: "#fff";
      t.string :h2_color, default: "#eee";
      t.string :body_bg, default: "#fff";
      t.string :body_color, default: "#333";
      t.string :btn_bg, default: "#1652f0";
      t.string :btn_color, default: "#fff"

      t.integer :border_radius, default: 10
      t.integer :photo_border_radius, default: 8
      t.integer :photo_border_width, default: 4
      t.integer :photo_size, default: 85
      t.integer :h1_size, default: 20
      t.integer :h2_size, default: 14

      t.timestamps
    end
  end
end
