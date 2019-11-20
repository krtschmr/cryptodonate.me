# Developed by TimVanMonero during his live streams

# RFC


##Easy words to describe what this aims to solve

- Accept Bitcoin (and other currencies in the future) and have donations shown up on your stream as regular donation messages.
- Keep track of top donators and statistics.
- have it modular and flexible so it's easy to extend
- Provide an overlay for the streamer which is highly customizable


## Flow

  - connect with oAuth twitch/mixer
  - alternatively create an own account (?)

  - use us as a wallet provider:
    - we collect the funds for the user
    - user can click *withdraw* at anytime
    - no verification required    
    - we deduct 1% fee
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
https://github.com/KeyMailer/omniauth-mixer
