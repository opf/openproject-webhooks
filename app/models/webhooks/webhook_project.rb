module Webhooks
  class Project < ActiveRecord::Base
    belongs_to :webhook
    belongs_to :project

    validates_presence_of :project
  end
end