module Twillio
  extend self

  # Twillio.client
  def client
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @client ||= Twilio::REST::Client.new account_sid, auth_token
  end
end

