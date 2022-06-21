require_relative '../umd_lib_environment_banner_helper'

# insert our custom cite_url_and_timestamp method into the Record class
# to display the EAD location (if present); falls back to the ASpace PUI URL
Rails.application.config.after_initialize do
  Record.class_eval do
    def cite_url_and_timestamp
      url = @json['ead_location'] || "#{AppConfig[:public_proxy_url].sub(/^\//, '')}#{uri}"
      "#{url}  #{I18n.t('accessed')}  #{Time.now.strftime("%B %d, %Y")}"
    end
  end
end

# Addition to navigation main menu
Plugins::add_menu_item('/', 'brand.home', 0)
Plugins::add_menu_item('https://www.lib.umd.edu/help-using-archival-collections', 'help_tab')

# URL for website feedback
AppConfig[:website_feedback_url] = 'https://libumd.wufoo.com/forms/rb2fewh0i9d7bc/'
