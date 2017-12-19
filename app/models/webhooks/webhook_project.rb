module Webhooks
  class WebhookProject < ActiveRecord::Base
    belongs_to :webhook
    belongs_to :project

    validates_presence_of :project
  end
end