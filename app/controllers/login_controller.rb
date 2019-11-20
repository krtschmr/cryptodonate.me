class LoginController <  Devise::OmniauthCallbacksController

  def mixer
    login_with_oauth(:mixer)
  end

  def twitch
    login_with_oauth(:twitch)
  end

  private

  def login_with_oauth(provider)
    user_by_oauth(provider)
    sign_in(@user)
    redirect_to root_path
  end

  def user_by_oauth(provider)
    hash = request.env["omniauth.auth"]
    @user = User.by_oauth(hash) || User.create do |u|
      u.provider = hash["provider"]
      u.uid = hash["uid"]
      u.name = hash["info"]["name"]
      u.email = hash["info"]["email"]
      u.url = hash["info"]["urls"][provider.to_s.capitalize]
      u.token = hash["credentials"]["token"]
      u.refresh_token = hash["credentials"]["refresh_token"]
    end
  end
end




{"provider"=>"mixer",
 "uid"=>103550931,
 "info"=>{"name"=>"TimVanMonero", "email"=>"tim@krtschmr.de", "description"=>nil, "image"=>nil, "social"=>{}, "urls"=>{"Mixer"=>"http://mixer.com/TimVanMonero"}},
 "credentials"=>
  {"token"=>"jr5ncAFUPJMYPHpYThd7pDqseCjJk74TsbMoXHwxnXPxK2qse2Ep64v6dxKpQtdE",
   "refresh_token"=>"ai8TJKzuebhHbtBz0MzTK2iv3okcztfssJtaB2LFXv4nrTTtJsdMHhBCq8TKDHnO",
   "expires_at"=>1574247742,
   "expires"=>true},
 "extra"=>
  {"raw_info"=>
    {"avatarUrl"=>nil,
     "bio"=>nil,
     "channel"=>
      {"id"=>93024996,
       "audience"=>"family",
       "badgeId"=>nil,
       "bannerUrl"=>nil,
       "costreamId"=>nil,
       "coverId"=>nil,
       "createdAt"=>"2019-08-04T07:18:03.000Z",
       "deletedAt"=>nil,
       "description"=>nil,
       "featured"=>false,
       "featureLevel"=>0,
       "ftl"=>93024996,
       "hasTranscodes"=>true,
       "hasVod"=>false,
       "hosteeId"=>nil,
       "interactive"=>false,
       "interactiveGameId"=>nil,
       "languageId"=>"en",
       "name"=>"Programming Ruby on Rails. Watch me creating the future!",
       "numFollowers"=>0,
       "online"=>false,
       "partnered"=>false,
       "suspended"=>false,
       "thumbnailId"=>nil,
       "token"=>"TimVanMonero",
       "transcodingProfileId"=>nil,
       "typeId"=>23202,
       "updatedAt"=>"2019-08-05T11:02:30.572Z",
       "userId"=>103550931,
       "viewersCurrent"=>0,
       "viewersTotal"=>11,
       "vodsEnabled"=>true},
     "createdAt"=>"2019-08-04T07:18:03.000Z",
     "deletedAt"=>nil,
     "email"=>"tim@krtschmr.de",
     "experience"=>1644,
     "frontendVersion"=>nil,
     "groups"=>[{"id"=>1, "name"=>"User"}],
     "id"=>103550931,
     "level"=>26,
     "preferences"=>
      {"chat:sounds:play"=>"whoosh",
       "chat:sounds:html5"=>true,
       "chat:timestamps"=>false,
       "chat:whispers"=>true,
       "chat:chromakey"=>false,
       "chat:lurkmode"=>false,
       "channel:notifications"=>{"ids"=>["*"], "transports"=>["notify", "email"]},
       "channel:mature:allowed"=>true,
       "channel:player"=>{"vod"=>"light", "rtmp"=>"light", "ftl"=>"light"},
       "chat:tagging"=>true,
       "chat:colors"=>true,
       "chat:sounds:volume"=>1,
       "chat:ignoredUsers"=>[],
       "channel:chatfilter:threshold"=>8,
       "global:dialog:seenFtue"=>false,
       "global:skills:completedFtue"=>false},
     "primaryTeam"=>nil,
     "social"=>{"verified"=>[]},
     "sparks"=>46550,
     "storeSettings"=>{"id"=>"103550931", "msaCountryCode"=>nil},
     "twoFactor"=>{"enabled"=>false, "codesViewed"=>false},
     "updatedAt"=>"2019-08-05T03:35:56.325Z",
     "username"=>"TimVanMonero",
     "verified"=>true}}}
