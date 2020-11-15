class DonationPageStyling < ApplicationRecord

  belongs_to :streamer


  [:border_radius, :photo_border_radius, :photo_border_width, :photo_size, :h1_size, :h2_size].each do |field|
    validates field, numericality: {greater_than_or_equal_to: 0, only_integer: true, less_than: 150}
  end
  [:bg, :header_bg, :photo_border_color, :h1_color, :h2_color, :body_bg, :body_color, :btn_bg, :btn_color].each do |field|
    validates_format_of field, with: /\A#(?:[A-F0-9]{3}){1,2}\z/i
  end


  before_commit :refresh_template!, on: [:create, :update]
  before_destroy :delete_css_file

  def self.permitted_attributes
    new.variables.keys
  end

  def refresh_template!
    p "start refreshing compiled template" if Rails.env.development?
    CssCompiler.run(streamer, variables)
    p "finished refreshing compiled template" if Rails.env.development?
  end

  def variables
    attributes.except("created_at", "updated_at", "id", "streamer_id")
  end

  private

  def delete_css_file
    File.delete("./public/styles/#{streamer.uuid}.css")
  end

  
end

# == Schema Information
#
# Table name: donation_page_stylings
#
#  id                  :integer          not null, primary key
#  bg                  :string           default("#eff1f4")
#  body_bg             :string           default("#fff")
#  body_color          :string           default("#333")
#  border_radius       :integer          default(10)
#  btn_bg              :string           default("#1652f0")
#  btn_color           :string           default("#fff")
#  h1_color            :string           default("#fff")
#  h1_size             :integer          default(20)
#  h2_color            :string           default("#eee")
#  h2_size             :integer          default(14)
#  header_bg           :string           default("#122332")
#  info_text           :string           default("Thanks for your donation")
#  photo_border_color  :string           default("#fff")
#  photo_border_radius :integer          default(8)
#  photo_border_width  :integer          default(4)
#  photo_size          :integer          default(85)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  streamer_id         :integer
#
# Indexes
#
#  index_donation_page_stylings_on_streamer_id  (streamer_id)
#
