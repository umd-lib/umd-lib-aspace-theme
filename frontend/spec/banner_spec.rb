require 'rails'
require 'socket'
require 'spec_helper'
require 'rails_helper'
require_relative '../../umd_lib_environment_banner_helper.rb'

# Resets the UMDLibEnvironmentBannerHelper, which is needed because the
# banner HTML is typically only generated when the module is initialized.
def reset_banner_helper
  UMDLibEnvironmentBannerHelper.class_variable_set :@@banner_initialized, false
  # Object.send(:remove_const, :UMDLibEnvironmentBannerHelper)
  # load '../../umd_lib_environment_banner_helper.rb'
end

# Helper class to enable banner use in tests
class TestBannerHelper
  include UMDLibEnvironmentBannerHelper
end

describe UMDLibEnvironmentBannerHelper do
  it 'returns the proper banner based on hostname/environment variables' do
    ENV.clear

    # Hostname banner - Local
    reset_banner_helper
    test_banner_helper = TestBannerHelper.new
    allow(Socket).to receive(:gethostname).and_return("test-local")
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq("<div class='environment-banner' id='environment-local'>Local Environment</div>")

    # Hostname banner - Development
    reset_banner_helper
    allow(Socket).to receive(:gethostname).and_return("test-dev")
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq("<div class='environment-banner' id='environment-development'>Development Environment</div>")

    # Hostname banner - Staging
    reset_banner_helper
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq("<div class='environment-banner' id='environment-staging'>Staging Environment</div>")

    # Hostname banner - Production (No banner)
    reset_banner_helper
    allow(Socket).to receive(:gethostname).and_return("test-production")
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq(nil)

    # Environment variable-based bannner
    reset_banner_helper
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    ENV['ENVIRONMENT_BANNER'] = 'Test Banner'
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq("<div class='environment-banner'>Test Banner</div>")

    # Environment variable-based bannner
    reset_banner_helper
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    ENV['ENVIRONMENT_BANNER'] = 'Test Banner'
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = '#000000'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = '#ffffff'
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq("<div class='environment-banner' style='background-color: #000000; color: #ffffff;'>Test Banner</div>")

    # ENVIRONMENT_BANNER_ENABLED takes precedence
    reset_banner_helper
    ENV['ENVIRONMENT_BANNER_ENABLED'] = 'false'
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    html = test_banner_helper.umd_lib_environment_banner
    expect(html).to eq(nil)
  end
end

describe UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner do
  it 'returns an environment banner based on ENV variables' do
    ENV.clear

    ENV['ENVIRONMENT_BANNER'] = 'Test Banner'

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new

    expect(banner.text).to eq('Test Banner')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(1)
    expect(banner.css_options[:class]).to eq('environment-banner')

    ENV['ENVIRONMENT_BANNER'] = 'Test Banner'
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = '#000000'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = '#ffffff'

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new

    expect(banner.text).to eq('Test Banner')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:style]).to eq('background-color: #000000; color: #ffffff;')
  end

  it 'is disabled, if no ENVIRONMENT_BANNER environment variable is provided' do
    ENV.clear

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new
    expect(banner.enabled?).to eq(false)

    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = '#000000'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = '#ffffff'

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new

    expect(banner.enabled?).to eq(false)
  end

  it 'is disabled, if ENVIRONMENT_BANNER_ENABLED environment variable is false' do
    ENV.clear

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new
    expect(banner.enabled?).to eq(false)

    ENV['ENVIRONMENT_BANNER'] = 'Test Banner'
    ENV['ENVIRONMENT_BANNER_BACKGROUND'] = '#000000'
    ENV['ENVIRONMENT_BANNER_FOREGROUND'] = '#ffffff'
    ENV['ENVIRONMENT_BANNER_ENABLED'] = 'false'

    banner = UMDLibEnvironmentBannerHelper::EnvVarsEnvironmentBanner.new

    expect(banner.enabled?).to eq(false)
  end

end

describe UMDLibEnvironmentBannerHelper::HostEnvironmentBanner do
  it 'returns an environment banner based on hostname' do
    ENV.clear

    # Local
    allow(Socket).to receive(:gethostname).and_return("test-local")
    banner = UMDLibEnvironmentBannerHelper::HostEnvironmentBanner.new

    expect(banner.text).to eq('Local Environment')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:id]).to eq('environment-local')

    # Development
    allow(Socket).to receive(:gethostname).and_return("test-dev")
    banner = UMDLibEnvironmentBannerHelper::HostEnvironmentBanner.new

    expect(banner.text).to eq('Development Environment')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:id]).to eq('environment-development')

    # Stage
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    banner = UMDLibEnvironmentBannerHelper::HostEnvironmentBanner.new

    expect(banner.text).to eq('Staging Environment')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:id]).to eq('environment-staging')

    # Rails development override hostname from Socket
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    allow(Rails.env).to receive(:development?).and_return(true)
    banner = UMDLibEnvironmentBannerHelper::HostEnvironmentBanner.new

    expect(banner.text).to eq('Local Environment')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:id]).to eq('environment-local')

    # Rails vagrant override hostname from Socket
    allow(Socket).to receive(:gethostname).and_return("test-stage")
    allow(Rails.env).to receive(:development?).and_return(false)
    allow(Rails.env).to receive(:vagrant?).and_return(true)
    banner = UMDLibEnvironmentBannerHelper::HostEnvironmentBanner.new

    expect(banner.text).to eq('Local Environment')
    expect(banner.enabled?).to eq(true)
    expect(banner.css_options.size).to eq(2)
    expect(banner.css_options[:class]).to eq('environment-banner')
    expect(banner.css_options[:id]).to eq('environment-local')
  end
end
