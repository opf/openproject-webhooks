require_relative 'base'

module OpenProject::Webhooks::EventResources
  class WorkPackages < Base
    class << self
      def notification_names
        [
          OpenProject::Events::AGGREGATED_WORK_PACKAGE_JOURNAL_READY
        ]
      end

      def available_events_map
        {
          work_package_created: localize_event_name(:created),
          work_package_updated: localize_event_name(:updated),
        }
      end

      def resource_name
        I18n.t :label_work_package_plural
      end

      protected

      def handle_notification(payload, event_name)
        action = payload[:initial] ? "created" : "updated"
        event_name = "work_package_#{action}"
        active_webhooks.with_event_name(event_name).pluck(:id).each do |id|
          Delayed::Job.enqueue WorkPackageWebhookJob.new(id, payload[:journal_id], event_name)
        end
      end
    end
  end
end