class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Wordsテーブルとの関連付け
  has_many :words, dependent: :destroy

  # Userモデル同士でメンターと学習者の関係を作成
  # mentor_idカラムを使って、ある学習者のメンター（Userモデル）を関連付ける
  has_one :mentee, class_name: 'User', foreign_key: 'mentor_id', dependent: :nullify
  belongs_to :mentor, class_name: 'User', optional: true

  # 学習者が作成した日報を関連付け
  has_many :reports, dependent: :destroy

  # roleのバリデーション
  validates :role, presence: true, inclusion: { in: Role.all.map(&:id) } # 不正なroleの値（0:学習者, 1:メンター以外）を拒否
  validates :nickname, presence: true
  validates :email, presence: true



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
