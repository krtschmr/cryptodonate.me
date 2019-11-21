class Donation < ApplicationRecord

  belongs_to :user
  belongs_to :coin
  has_many :crypto_payments

end
