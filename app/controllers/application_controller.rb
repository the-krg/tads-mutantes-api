class ApplicationController < ActionController::API
  before_action :set_host_for_local_storage

  private
  
  def set_host_for_local_storage
    ActiveStorage::Current.host = request.host_with_port
  end

  def validate_user; end
end
