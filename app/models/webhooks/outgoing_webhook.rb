module Webhooks
  class OutgoingWebhook < ActiveRecord::Base

    validates_presence_of :name
    validates_presence_of :url

    validates_uniqueness_of :name
    validates :url, url: true

    serialize :events, Array
    serialize :project_ids, Array
    serialize :type_ids, Array

    validate :validate_event_existence
    validate :validate_projects
    validate :validate_types

    def project_ids
      serialized = read_attribute :project_ids
      Project.where(id: serialized).pluck(:id)
    end

    def type_ids
      serialized = read_attribute :type_ids
      Type.where(id: serialized).pluck(:id)
    end

    private

    def validate_event_existence
      # TODO
    end

    def validate_projects
      validate_serialized_ids :project_ids
    end

    def validate_types
      validate_serialized_ids :type_ids
    end

    def validate_serialized_ids(attr)
      serialized = read_attribute attr
      found = send(attr)

      if serialized.length != found.length
        errors.add :attr, :invalid
      end
    end
  end
end