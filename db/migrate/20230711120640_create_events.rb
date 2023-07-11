class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :image 
      t.text :venue
      t.date :date
      t.string :category
    end
  end
end
