module Webhooks
  class Log < ActiveRecord::Base
    belongs_to :webhooks_webhook
    belongs_to :webhooks_event

    validates :action, presence: true
    validates :url, presence: true
    validates :response_cdoe, presence: true
  end
end