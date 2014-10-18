class AddDefaultValuesForStory < ActiveRecord::Migration
  def change
    change_column :stories, :total_pieces, :integer,  :default => 6
    change_column :stories, :max_sentences, :integer, :default => 3
  end
end
