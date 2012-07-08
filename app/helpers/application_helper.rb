module ApplicationHelper

  MAIN_APP_SUBD_COUNT = 1

  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    app_subd = app_subdomain
    app_subd += "." unless app_subd.empty?
    [subdomain, app_subd, request.domain].join
  end

  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end

  def app_subdomain
    return "" if MAIN_APP_SUBD_COUNT
    subds = request.subdomain.split(".")
    subds[-MAIN_APP_SUBD_COUNT, -1].join(".")
  end

  def crm_subdomain
    subds = request.subdomain.split(".")
    return "" if subds.count == MAIN_APP_SUBD_COUNT
    subd = request.subdomain["."] ? request.subdomain[/\A(.+)\./, 0].chop : request.subdomain
  end
end
