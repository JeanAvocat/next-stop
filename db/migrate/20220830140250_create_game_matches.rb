class CreateGameMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :game_matches do |t|
      t.string :winner
      t.references :matchable, null: false, polymorphic: true
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
