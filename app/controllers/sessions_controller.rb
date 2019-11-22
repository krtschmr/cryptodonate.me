class SessionsController < ApplicationController

  def logout
    sign_out(current_streamer)
    redirect_to root_path
  end
end
