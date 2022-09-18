class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :user
      t.integer :article
      t.string :text
      t.timestamps
    end
  end
end
