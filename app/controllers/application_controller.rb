class ApplicationController < ActionController::Base
  protect_from_forgery

  HOSTING_DOMAIN_NAME = ".gigimus.herokuapp.com"

  include ApplicationHelper

  before_filter :redirect_to_sign_in_page_if_not_signed_in
  before_filter :redirect_to_root_with_correct_subdomain_if_subdomain_is_invalid

  helper_method :current_user

  PAGE_COUNT = 5

  protected

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.authenticate_with_sid(cookies[:s_id])
  end

  def sign_in(user)
    cookies.permanent[:s_id] = {value: user.secure_id, :domain => HOSTING_DOMAIN_NAME}
    current_user = user
  end

  def redirect_to_sign_in_page_if_not_signed_in
    unless current_user
      redirect_to new_session_path
    end
  end

  def tasks_documents_owner_path(model_name)
    methods = { :case_id => method(:case_path),
      :person_id => method(:person_path),
      :opportunity_id => method(:opportunity_path),
      :none => method(:tasks_path) }

    methods[tasks_documents_owner_id(model_name)].
      call(params[model_name][tasks_documents_owner_id(model_name)])
  end

  def tasks_documents_owner_id(model_name)
    [:case_id, :opportunity_id, :person_id].each { |e|
      return e if params[e]
      return e if !params[model_name].nil? and !params[model_name][e].blank?
    }

    return :none
  end

  def redirect_to_root_with_correct_subdomain_if_subdomain_is_invalid
    redirect_to root_url(:subdomain => current_user.subdomain) if current_user.subdomain != crm_subdomain
  end
end
