
development should continue!

# Developed by TimVanMonero during his live streams

# RFC


##Easy words to describe what this aims to solve

- Accept Bitcoin (and other currencies in the future) and have donations shown up on your stream as regular donation messages.
- Keep track of top donators and statistics.
- have it modular and flexible so it"s easy to extend
- Provide an overlay for the streamer which is highly customizable


## Flow

  - connect with oAuth twitch
  - alternatively create an own account (?)

  - use us as a wallet provider:
    - we collect the funds for the user
    - user can click *withdraw* at anytime
    - no verification required    
    - we deduct 1% fee min 20_000 satoshis
    - user has all kinds of features

  - provide us your xpubkey:
    - we create addresses based on /0/0/n
    - we keep track of those addresses
    - only provide basic overlay

  - have custom callbacks for donations
  - have streamlabs and streamelements integration
  - similar donation form to https://streamelements.com/timvanmonero/tip
  - In future have acceptances for all Bitcoin forks based on bitcoin-core.


https://github.com/WebTheoryLLC/omniauth-twitch


curl -H 'Authorization: Bearer ' -X GET 'https://api.streamelements.com/kappa/v2/tips/5d29bb4406f75d15ac92a9c3'
{
    "currency": "BTC",
    "user": {
        "username": "styler",
        "email": "styler@streamelements.com"
    },
    "amount": 12,
    "message": "12312313",
    "provider": "<provider-name>",
    "transactionId": "<ID>",
}

models
  :coins (:btc, :bch, :doge, :ltc)
  :exchange_rates (with ruby_money as the bank)
  :user
    -> settings
  :donation
    donation_counter # (1,2,3....) to derived by xpubkey
    sender: string
    message: string(255)
    currency (eur, :usd, :thb, :gbp)
    exchange_rate
    value: 10
    :coin
    :payment_amount
    payment within 10 minutes of generation detected?
      -> display as 10$ value
      -> otherwise recalculate value and display as 9.92$

   :overlay
     width
     height
     -> modules



# Layout

To buy, for just 18$. can't we steal? :< they don't accept bitcoin!

https://themeforest.net/item/metrica-responsive-admin-multi-dashboard-template/23997762


# Flow

-> Create donation
-> Donation has many payment_addresses, display those to the user
-> User can pay to address

Detected Payment:
-> IncomingTransaction.create
  -> Create DonationPayment, state: :pending
    -> Update Donation, state: :detected
    -> call rules for notifications?

-> IncomingTransaction.update(confirmation: 1)
  -> Update DonationPayment, state: :confirmed
    -> Create LedgerEntry
    -> Update Donation state: :paid
    -> call rules for notifications unless already notified








# License (TVM License)

You are permitted to use this project in your personal development environment for testing and learning purposes. You are allowed to make improvements and submit pull requests. You are not allowed to use any of the code, in a commercial or production environment. You are not allowed to add bugs, said ratatapowpow. MrZax2000 also said, that this is a serious thing.

This is a community project, created by Tim Van Monero (live streamed on twitch.tv). Its sole purpose is to help Streamers to receive crypto donations.


Noticeable mentions: When asking if somebody haven't been mentioned in the TVM License, someone felt _exhiled_ and had to *cough cough*


------

for serious webdesign, have a look here: https://www.twitch.tv/videos/470208236
