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

    after_initialize :set_all_projects

    def set_all_projects
      self.all_projects = true if new_record?
    end

    def all_projects?
      all_projects
    end

    def event_names
      self.events.pluck(:name)
    end

    def event_names=(names)
      self.events = names.map { |name| events.build(name: name) }
    end
  end
end