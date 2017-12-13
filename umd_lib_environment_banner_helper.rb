require 'socket'

module UMDLibEnvironmentBannerHelper

  @@environment_name = case Socket.gethostname.split(".").first
                       when /local$/
                        'Local'
                       when /dev$/
                        'Development'
                       when /stage$/
                         'Staging'
		                   end 
 
  def environment_name 
   ( Rails.env.development? || Rails.env.vagrant? ) ? "Local" : @@environment_name
  end
  
  # https://confluence.umd.edu/display/LIB/Create+Environment+Banners
  def umd_lib_environment_banner
    if environment_name
      "<div class='environment-banner' id='environment-#{environment_name.downcase}'>#{environment_name} Environment</div>".html_safe
    end
  end

end

# here we reopen the ApplicationController (after Rails has started)
# and stick in our helper module.
Rails.application.config.after_initialize do
    ApplicationController.class_eval do
      include UMDLibEnvironmentBannerHelper
      helper_method :umd_lib_environment_banner
    end
end
