module ::Webhooks
  module Outgoing
    class RowCell < ::RowCell
      include ::IconsHelper

      def webhook
        model
      end

      def row_css_class
        'webhooks--outgoing-webhook-row'.freeze
      end

      ###

      def button_links
        [edit_link, delete_link]
      end

      def edit_link
        link_to I18n.t(:edit),
                { controller: table.target_controller, action: :edit, webhook_id: webhook.id },
                class: 'button--link'
      end

      def delete_link
        link_to I18n.t(:button_delete),
                { controller: table.target_controller, action: :destroy, webhook_id: webhook.id },
                class: 'button--link'
      end

      def column_css_class(column)
        if device.default
          'mobile-otp--device-default'
        end
      end
    end
  end
end
