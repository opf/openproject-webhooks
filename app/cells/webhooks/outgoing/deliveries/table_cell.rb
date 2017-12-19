module ::Webhooks
  module Outgoing
    module Deliveries
      class TableCell < ::TableCell
        columns :id, :action, :time, :response_code

        def sortable?
          false
        end

        def empty_row_message
          I18n.t 'webhooks.outgoing.deliveries.no_results_table'
        end

        def headers
          [
              ['id', caption: I18n.t('attributes.id')],
              ['action', caption: ::Webhooks::Log.human_attribute_name('projects')],
              ['time', caption: I18n.t('webhooks.outgoing.deliveries.time')],
              ['response_code', caption: ::Webhooks::Log.human_attribute_name('response_code')],
          ]
        end
      end
    end
  end
end
