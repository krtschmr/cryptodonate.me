class CreateConnectedPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :connected_platforms do |t|
      t.belongs_to :streamer
      t.string :provider, null: false, index: true
      t.string :uid
      t.string :name
      t.string :token, null: false
      t.string :refresh_token, null: false
      t.timestamps
    end
    add_index :connected_platforms, [:streamer_id, :provider], unique: true
  end
end
