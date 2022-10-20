class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.integer :amount
      t.string :host
      t.string :participant

      t.timestamps
    end
  end
end
