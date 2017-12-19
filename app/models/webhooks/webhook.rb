module Webhooks
  class Webhook < ActiveRecord::Base
    default_scope { order(id: :asc) }

    validates_presence_of :name
    validates_presence_of :url

    validates_uniqueness_of :name
    validates :url, url: true

    has_many :events, foreign_key: :webhooks_webhook_id, class_name: '::Webhooks::Event', dependent: :delete_all
    has_many :webhook_projects, foreign_key: :webhooks_webhook_id, class_name: '::Webhooks::Project', dependent: :delete_all
    has_many :projects, through: :webhook_projects
    has_many :deliveries, foreign_key: :webhooks_webhook_id, class_name: '::Webhooks::Log', dependent: :delete_all

    def self.enabled
      where(enabled: true)
    end

    def self.with_event_name(event_name)
      enabled
        .joins(:events)
        .where("#{::Webhooks::Event.table_name}.name" => event_name)
    end

    def self.new_default
      new all_projects: true, enabled: true
    end

    def all_projects?
      !!all_projects
    end

    def enabled?
      !!enabled
    end

    def event_names
      self.events
        .pluck(:name)
        .map(&:to_sym)
    end

    def event_names=(names)
      self.events = names.map { |name| events.build(name: name) }
    end
  end
end