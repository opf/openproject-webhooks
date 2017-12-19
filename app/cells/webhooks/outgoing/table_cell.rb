module ::Webhooks
  module Outgoing
    class TableCell < ::TableCell
      columns :name, :enabled, :selected_projects, :description

      def initial_sort
        [:id, :asc]
      end

      def target_controller
        'webhooks/outgoing/admin'
      end

      def sortable?
        false
      end

      def inline_create_link
        link_to({ controller: target_controller, action: :new },
                class: 'webhooks--add-row wp-inline-create--add-link',
                title: I18n.t('webhooks.outgoing.label_add_new')) do
            op_icon('icon icon-add')
        end
      end

      def empty_row_message
        I18n.t 'webhooks.outgoing.no_results_table'
      end

      def headers
        [
            ['name', caption: I18n.t('attributes.name')],
            ['enabled', caption: I18n.t(:label_active)],
            ['selected_projects', caption: Webhooks::Webhook.human_attribute_name('projects')],
            ['description', caption: I18n.t('attributes.description')]
        ]
      end
    end
  end
end
