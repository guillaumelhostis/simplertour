class CreateTransportUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end
