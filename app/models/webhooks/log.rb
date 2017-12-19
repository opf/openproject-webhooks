module Webhooks
  class Log < ActiveRecord::Base
    belongs_to :webhook, foreign_key: :webhooks_webhook_id, class_name: '::Webhooks::Webhook', dependent: :destroy
    belongs_to :event, foreign_key: :webhooks_event_id, class_name: '::Webhooks::Event', dependent: :destroy

    validates :action, presence: true
    validates :url, presence: true
    validates :response_code, presence: true
  end
end
