class HomeController < ApplicationController
  def logs
    render locals: { logs: %x{tail -20 log/custom_sidekiq.log}.split("\n") }
  end
end
