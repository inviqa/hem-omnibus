## Rubygems Customization ##
# Customize rubygems install behavior and locations to keep user gems isolated
# from the stuff we bundle with omnibus and any other ruby installations on the
# system.

# Always install and update new gems in "user install mode"
Gem::ConfigFile::OPERATING_SYSTEM_DEFAULTS["install"] = "--user"
Gem::ConfigFile::OPERATING_SYSTEM_DEFAULTS["update"] = "--user"

module Gem

  ##
  # Override user_dir to live inside of ~/.hem

  class << self
    # Remove method before redefining so we avoid a ruby warning
    remove_method :user_dir

    def user_dir
      parts = [Gem.user_home, '.hem', 'gems', ruby_engine]
      parts << RbConfig::CONFIG['ruby_version'] unless RbConfig::CONFIG['ruby_version'].empty?
      File.join parts
    end
  end
end
