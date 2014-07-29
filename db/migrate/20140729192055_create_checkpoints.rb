class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.string :name

      t.timestamps
    end
  end
end
