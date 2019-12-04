class AddInfoTextToDonationPageStyling < ActiveRecord::Migration[6.0]
  def change
    add_column :donation_page_stylings, :info_text, :string, default: "Thanks for your donation"
  end
end
