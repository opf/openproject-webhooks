class CreateWebhookLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :webhook_logs do |t|
      t.references :webhook, foreign_key: { on_delete: :cascade }
      t.references :event, foreign_key: { on_delete: :cascade }
      t.string :action
      t.string :url
      t.int :response_code
      t.string :response_body

      t.timestamps
    end
  end
end
