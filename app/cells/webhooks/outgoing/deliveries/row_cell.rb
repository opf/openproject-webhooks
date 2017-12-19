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
      end
    end
  end
end