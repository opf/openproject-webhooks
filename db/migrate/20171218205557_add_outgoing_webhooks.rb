class AddOutgoingWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :outgoing_webhooks do |t|
      t.string :name
      t.text :url
      t.text :description, null: false
      t.string :secret, null: true
      t.text :events
      t.text :project_ids
      t.text :type_ids

      t.timestamps
    end
  end
end
