class CreateMerchants < ActiveRecord::Migration[6.1]
  def change
    create_table :merchants, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :company_name

      t.timestamps
    end
  end
end
