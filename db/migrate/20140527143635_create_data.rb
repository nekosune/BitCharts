class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.decimal :date
      t.decimal :open
      t.decimal :close
      t.decimal :min
      t.decimal :max
      t.decimal :volbtc
      t.decimal :voldol

      t.timestamps
    end
  end
end
