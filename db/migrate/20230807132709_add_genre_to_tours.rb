class AddGenreToTours < ActiveRecord::Migration[7.0]
  def change
    add_column :tours, :genre, :string
  end
end
