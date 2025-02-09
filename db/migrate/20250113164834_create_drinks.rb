class CreateDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :drinks do |t|
      t.string :name, null: false   # ドリンク名
      t.text :description, null: false  # 本文
      t.float :alcohol, null:false    # アルコール度数
      t.string :drink_image, null:false   # ドリンク画像
      t.string :drink_type, null:false    # アルコールorノンアルコール
      t.text :mixing_instructions   # 作り方
      t.references :user, null: false, foreign_key: true   # 投稿者

      t.timestamps
    end
  end
end
