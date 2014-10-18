class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.references :story, index: true
      t.references :user, index: true
      t.text :text

      t.timestamps
    end
  end
end
