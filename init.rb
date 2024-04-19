require 'redmine'

require File.expand_path('../lib/redmine_mattermost/listener', __FILE__)

Redmine::Plugin.register :redmine_mattermost do
	name 'Redmine Mattermost'
	author 'AltSol'
	url 'https://github.com/altsol/redmine_mattermost'
	author_url 'http://altsol.gr'
	description 'Mattermost chat integration'
	version '0.6'

	requires_redmine :version_or_higher => '5.1.2'

	settings \
		:default => {
			'callback_url' => 'http://example.com/callback/',
			'channel' => nil,
			'icon' => 'https://raw.githubusercontent.com/altsol/redmine_mattermost/assets/icon.png',
			'username' => 'redmine',
			'display_watchers' => 'no'
		},
		:partial => 'settings/mattermost_settings'
end

Rails.application.config.after_initialize do
	unless Issue.included_modules.include? RedmineMattermost::IssuePatch
		Issue.send(:include, RedmineMattermost::IssuePatch)
	end
end
