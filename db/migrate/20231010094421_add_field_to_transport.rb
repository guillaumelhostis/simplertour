class AddFieldToTransport < ActiveRecord::Migration[7.0]
  def change
    add_column :transports, :notes, :string
  end
end
