class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name,                     null: false                           # ユーザーネーム
      t.string :email,                    null: false, index: { unique: true }  # メールアドレス
      t.string :crypted_password                                                # 暗号化されたパスワード
      t.string :salt
      t.string :reset_password_token                                            # パスワードリセットトークン
      t.datetime :reset_password_sent_at                                        # パスワードリセットリクエストの日時

      t.timestamps                        null: false                           # 作成・更新日時
    end
  end
end
