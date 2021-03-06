# coding: UTF-8
require 'oauth/controllers/provider_controller'

class OauthController < ApplicationController
  layout 'front_layout'  
  include OAuth::Controllers::ProviderController
  
  ssl_required :authorize, :request_token, :access_token, :token, :test_request
  
  prepend_before_filter do
    warden.custom_failure!
  end
  
  # XAuth ref: https://dev.twitter.com/docs/oauth/xauth
  def access_token_with_xauth
    if params[:x_auth_mode] == 'client_auth'
      if user = User.authenticate(params[:x_auth_username], params[:x_auth_password])
        @token = AccessToken.filter(:user => user, :client_application => current_client_application, :invalidated_at => nil).limit(1).first
        @token = AccessToken.create(:user => user, :client_application => current_client_application) if @token.blank?

        if @token
          render :text => @token.to_query
        else
          render_unauthorized
        end
      else
        render_unauthorized
      end
    else
      access_token_without_xauth
    end
  end
  alias_method_chain :access_token, :xauth


  protected

  def render_unauthorized
    head :unauthorized
  end
end
