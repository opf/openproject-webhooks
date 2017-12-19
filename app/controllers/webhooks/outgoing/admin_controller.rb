module Webhooks
  module Outgoing
    class AdminController < ::ApplicationController
      layout 'admin'

      before_action :require_admin
      before_action :find_webhook, only: [:show, :edit, :update, :destroy]

      def index
        @webhooks = webhook_class.all
      end

      def show; end
      def edit; end

      def new
        @webhook = webhook_class.new
      end

      def update
      end

      def destroy
        if @webhook.destroy
          flash[:notice] = I18n.t(:successful_delete)
        else
          flash[:error] = I18n.t(:error_failed_to_delete_entry)
        end

        redirect_to action: :index
      end

      private

      def find_webhook
        @webhook = webhook_class.find(params[:webhook_id])
      rescue ActiveRecord::RecordNotFound
        render_404
      end

      def webhook_class
        ::Webhooks::OutgoingWebhook
      end

      def webhooks_params
        params
          .require(:webhook)
          .permit(:name, :status, :description, :url, :projects, :types, :secret, :events)
      end

      def show_local_breadcrumb
        true
      end

      def default_breadcrumb
        []
      end
    end
  end
end