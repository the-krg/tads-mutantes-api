class JoinsMutantsAndPowers < ActiveRecord::Migration[5.2]
  def change
    create_table :mutants_powers, id: false do |t|
      t.belongs_to :power, index: true
      t.belongs_to :mutant, index: true
    end
  end
end
