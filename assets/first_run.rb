#!/usr/bin/env ruby

module SetHostName
  def self.perform
    system '/usr/sbin/auto_set_hostname.rb' or warn 'WARNING: Set hostname failed'
  end
end

module RunSoloist
  def self.perform
    system 'gem install soloist' or raise 'Installing soloist failed!'
    system 'soloist' or raise 'First soloist run failed!'
  end
end

module SelfTerminate
  def self.perform
    # We auto_set our hostname the FIRST time we boot; to prevent us from
    # setting the hostname every time we boot, we remove the plist file.
    if File.exists?("/Library/LaunchAgents/com.pivotallabs.first_run.plist")
      `sudo mv /Library/LaunchAgents/com.pivotallabs.first_run.plist /tmp/`
    end
  end
end

SetHostName.perform
RunSoloist.perform
SelfTerminate.perform
