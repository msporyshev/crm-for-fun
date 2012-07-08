module ApplicationHelper

  MAIN_APP_SUBD_COUNT = 1
  CRM_SUBDOMAIN_INDEX = 1

  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain].join
  end

  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end

  def crm_subdomain
    subds = request.subdomain.split(".")
    subds[-MAIN_APP_SUBD_COUNT - CRM_SUBDOMAIN_INDEX]
  end
end
