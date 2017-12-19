module Webhooks
  class Webhook < ActiveRecord::Base
    default_scope { order(id: :asc) }

    validates_presence_of :name
    validates_presence_of :url

    validates_uniqueness_of :name
    validates :url, url: true

    has_many :events, foreign_key: :webhook_id, class_name: 'WebhookEvent', dependent: :destroy
    has_many :webhook_projects
    has_many :projects, through: :webhook_projects, dependent: :destroy

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