module Webhooks
  class WebhookLog < ActiveRecord::Base
    belongs_to :webhook
    belongs_to :event

    validates :action, presence: true
    validates :url, presence: true
    validates :response_cdoe, presence: true
  end
end