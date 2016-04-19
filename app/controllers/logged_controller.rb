class LoggedController < ApplicationController
  before_action :authenticate_user!
  layout "logged"
  prepend_view_path "app/views/logged"
end
