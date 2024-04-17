class AdminController < ActionController::Base
  layout 'application'
  before_action :authenticate_admin!
end