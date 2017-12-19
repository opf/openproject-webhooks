class CreateWebhookLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :webhook_logs do |t|
      t.references :webhook, foreign_key: { on_delete: :cascade }
      t.references :webhook_event, foreign_key: { on_delete: :cascade }
      t.string :action
      t.string :url
      t.integer :response_code
      t.string :response_body

      t.timestamps
    end
  end
end
