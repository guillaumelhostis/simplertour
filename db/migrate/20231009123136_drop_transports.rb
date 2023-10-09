class DropTransports < ActiveRecord::Migration[7.0]
  def change
    drop_table :transports
  end
end
