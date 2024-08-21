class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Wordsテーブルとの関連付け
  has_many :words, dependent: :destroy

  # roleのバリデーション
  validates :role, presence: true

  # メンター登録時に一意なコードを生成するためのコールバック
  before_create :generate_unique_code, if: :mentor?

  # 一意なコードを生成するメソッド
  def generate_unique_code
    loop do
      self.code = SecureRandom.hex(10)  # ランダムな16進数文字列を生成
      break unless User.exists?(code: code)  # 重複しないことを確認
    end
  end

  # ユーザーがメンターかどうかを確認するメソッド
  def mentor?
    role == 1  # 役割が1（メンター）であるかを確認
  end
end
