class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :text
      t.timestamps
    end
  end
end
