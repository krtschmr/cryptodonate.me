class AddEnabledToCoin < ActiveRecord::Migration[6.0]
  def change
    add_column :coins, :enabled, :boolean, default: false
  end
end
