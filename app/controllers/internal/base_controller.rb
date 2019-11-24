class Internal::BaseController < ActionController::Base

  before_action :authenticate_streamer!

  layout "internal"



end
