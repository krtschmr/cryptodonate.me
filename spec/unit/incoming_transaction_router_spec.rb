require 'rails_helper'

RSpec.describe IncomingTransactionRouter, type: :model do

  let!(:deposit_address) { "tb1q3vn3eqtcdqfdx397npfwgct7ktp472jqmlxpmg" }
  let!(:bitcoin) { FactoryBot.create :bitcoin }
  let!(:payment_address) { PaymentAddress.create coin: bitcoin, address: deposit_address}
  let!(:streamer) { FactoryBot.create :streamer }
  let!(:donation) { FactoryBot.create :donation, streamer: streamer}
  let!(:tx_id) { "ab00657ab9da484ff235add84f7db7820f32c3fe97d308b67da3df89165c529d" }


  describe "#process" do

    context "unconfirmed transaction" do
      it "creates a pending incoming transaction" do
        VCR.use_cassette('btc/unconfirmed', record: :new_episodes) do
          incoming = IncomingTransactionRouter.process(:btc, tx_id)
          expect(incoming).to be_persisted
          expect(incoming).to be_pending
          expect(incoming.amount).to eq(0.00668223)
          expect(incoming.tx_id).to eq(tx_id)
          expect(incoming.confirmations).to eq(0)
          expect(incoming.payment_address).to eq(payment_address)
        end
      end
    end

    context "unconfirmed transaction becomes confirmed" do
      it "changes the state of an incoming transaction" do
        incoming = VCR.use_cassette('btc/unconfirmed', record: :new_episodes) do
          IncomingTransactionRouter.process(:btc, tx_id)
        end
        expect(incoming).to be_pending
        incoming = VCR.use_cassette('btc/confirmed', record: :new_episodes) do
          IncomingTransactionRouter.process(:btc, tx_id)
        end
        expect(incoming).to be_confirmed
      end
    end

    context "confirmed transaction" do
      it "creates a confirmed incoming transaction" do
        VCR.use_cassette('btc/confirmed', record: :new_episodes) do
          incoming = IncomingTransactionRouter.process(:btc, tx_id)
          expect(incoming).to be_persisted
          expect(incoming).to be_confirmed
          expect(incoming.amount).to eq(0.00668223)
          expect(incoming.tx_id).to eq(tx_id)
          expect(incoming.block).to eq(1610218)
          expect(incoming.confirmations).to eq(1)
          expect(incoming.payment_address).to eq(payment_address)
        end
      end
    end

  end

end
