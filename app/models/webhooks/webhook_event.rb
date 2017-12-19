module Webhooks
  class WebhookEvent < ActiveRecord::Base
    belongs_to :webhook
    validates_associated :webhook
    validates_presence_of :name
  end
end