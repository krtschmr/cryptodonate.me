class SessionsController < ApplicationController

  def new
    return redirect_to [:internal, :root] if current_streamer
  end

  def logout
    sign_out(current_streamer)
    redirect_to(root_path)
  end
end
