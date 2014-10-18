class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :user, index: true
      t.string :title
      t.integer :total_pieces
      t.integer :max_sentences

      t.timestamps
    end
  end
end
