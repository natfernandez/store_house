class AddArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :code, :null => false, :limit => 4
      t.string :description, :null => false, :limit => 150
      t.date :voided_at
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
