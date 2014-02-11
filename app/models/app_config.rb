class AppConfig < Settingslogic
  config_file = File.expand_path("../../../config/app_config.yml"， __FILE__)
  raise "#{config_file} not exists!" unless File.exists?
  source config_file
  namespace Rails.env
  load!
end