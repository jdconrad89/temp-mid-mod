class AddPopularityToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :popularity, :integer, default: 0 
  end
end
