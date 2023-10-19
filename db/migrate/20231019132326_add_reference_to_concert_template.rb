class AddReferenceToConcertTemplate < ActiveRecord::Migration[7.0]
  def change
    add_reference :concert_templates, :tourman, foreign_key: true
  end
end
