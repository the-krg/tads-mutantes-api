class CreateMutants < ActiveRecord::Migration[5.2]
  def change
    create_table :mutants do |t|
      t.string :name, unique: true
      t.belongs_to :user

      t.timestamps
    end
  end
end
