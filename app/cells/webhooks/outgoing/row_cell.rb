module ::Webhooks
  module Outgoing
    class RowCell < ::RowCell
      include ::IconsHelper

      def webhook
        model
      end

      def enabled
        if model.enabled
          op_icon 'icon-yes'
        else
          op_icon 'icon-no'
        end
      end

      def events
        selected_events = model.events
        count = selected_events.count

        if count <= 3
          selected_events.pluck(:name).join(', ')
        else
          content_tag('span', count, class: 'badge -border-only')
        end
      end

      def selected_projects
        selected = model.project_ids.count

        if selected.zero?
         "(#{I18n.t(:label_all)})"
        elsif selected <= 3
          model.projects.pluck(:name).join(', ')
        else
          content_tag('span', selected, class: 'badge -border-only')
        end
      end

      def row_css_class
        'webhooks--outgoing-webhook-row'.freeze
      end

      ###

      def button_links
        [edit_link, delete_link]
      end

      def edit_link
        link_to I18n.t(:button_edit),
                { controller: table.target_controller, action: :edit, webhook_id: webhook.id },
                class: 'button--link'
      end

      def delete_link
        link_to I18n.t(:button_delete),
                { controller: table.target_controller, action: :destroy, webhook_id: webhook.id },
                data: { method: 'delete', confirm: I18n.t(:text_are_you_sure) },
                class: 'button--link'
      end
    end
  end
end
