class CreatePasswords < ActiveRecord::Migration[7.0]
  def change
    create_table :passwords do |t|
      t.string :number, null: false
      t.boolean :preferential, default: false
      t.string :sector
      t.string :service
      t.references :user, null: false, foreign_key: true
      t.boolean :canceled, default: false
      t.datetime :start_attendance
      t.datetime :end_attendance

      t.timestamps
    end
  end
end
