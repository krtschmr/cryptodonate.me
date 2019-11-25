class SessionsController < ApplicationController


  def new
    if current_streamer
      return redirect_to [:internal, :root]
    end
  end


  def logout
    sign_out(current_streamer)
    redirect_to root_path
  end
end
