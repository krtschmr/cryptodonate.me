class ConnectedPlatform < ApplicationRecord

  belongs_to :streamer, required: true
  validates :provider, uniqueness:{ scope: :streamer_id }

end

# == Schema Information
#
# Table name: connected_platforms
#
#  id            :integer          not null, primary key
#  name          :string
#  provider      :string           not null
#  refresh_token :string           not null
#  token         :string           not null
#  uid           :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  streamer_id   :integer
#
# Indexes
#
#  index_connected_platforms_on_provider                  (provider)
#  index_connected_platforms_on_streamer_id               (streamer_id)
#  index_connected_platforms_on_streamer_id_and_provider  (streamer_id,provider) UNIQUE
#
