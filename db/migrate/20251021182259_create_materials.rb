class CreateMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :materials do |t|
      t.string :title
      t.text :description
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
