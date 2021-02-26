class CreateCheckResults < ActiveRecord::Migration[6.1]
  def change
    create_table :check_results do |t|
      t.string :name
      t.string :result

      t.timestamps
    end
  end
end
