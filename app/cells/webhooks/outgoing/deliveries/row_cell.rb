module ::Webhooks
  module Outgoing
    module Deliveries
      class RowCell < ::RowCell
        include ::IconsHelper

        def log
          model
        end

        def time
          format_time model.updated_at
        end

        def response_body
          render locals: { log_entry: log }, prefixes: ["#{::OpenProject::Webhooks::Engine.root}/app/cells/views"]
        end
      end
    end
  end
end