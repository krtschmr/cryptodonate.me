class CryptoPayment < ApplicationRecord

    belongs_to :donation
    belongs_to :coin


end
