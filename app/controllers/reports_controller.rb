class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  # `show`, `edit`, `update`, `destroy` アクションの前に特定の日報をセット
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    if @user.mentee.present?
      @reports = @user.mentee.reports
    else
      @reports = @user.reports
    end

    # 日付フィルタリング
    if params[:start_date].present? && params[:end_date].present?
      @reports = @reports.where(created_at: params[:start_date]..params[:end_date])
    end



    # 作成日の降順で並べ替え、ページネーションを適用
    @reports = @reports.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    # `set_report` により対象の日報が @report にセットされている
  end

  def new
    # 新しい日報オブジェクトを作成
    @report = @user.reports.new
  end

  def create
    @report = @user.reports.new(report_params)
    if @report.save
      redirect_to user_reports_path(@user), notice: "日報を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  # `set_report` により対象の日報が @report にセットされている
  end

  def update
    # フィードバックが存在するかどうかでメッセージを分岐
    if @report.feedback.nil?
      if @report.update(report_params)
        redirect_to user_report_path(@user, @report), notice: "フィードバックが作成されました。"
      else
        render :show, status: :unprocessable_entity
      end
    else
      if @report.update(report_params)
        redirect_to user_report_path(@user, @report), notice: "フィードバックが更新されました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end



  def destroy
    if current_user.role == 1  # メンターの場合
      @report.update(feedback: nil)
      redirect_to user_report_path(@user, @report), notice: "フィードバックが削除されました。"
    else # 学習者の場合は日報全体を削除
      @report.destroy
      redirect_to user_reports_path(@user), notice: "日報を削除しました。"
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_report
    if current_user.role == 0  # 学習者の場合
      @report = current_user.reports.find(params[:id])
    elsif current_user.role == 1  # メンターの場合
      @report = current_user.mentee.reports.find(params[:id])
    end
  end

  def report_params
    params.require(:report).permit(:total_study_time, :good_points, :improvement_points, :next_steps, :next_study_day, :feedback, :comment)
  end

end
