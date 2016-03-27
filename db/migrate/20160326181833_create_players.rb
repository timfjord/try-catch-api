class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.belongs_to :team
      t.belongs_to :user

      t.timestamps
    end
  end
end
