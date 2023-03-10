class UsersController < ApplicationController

  before_action :authenticate_user! #ログイン認証されていなければ、ログイン画面へリダイレクトする
  before_action :ensure_correct_user, only: [:update, :edit] #edit追加

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    # @user = User.find(params[:id]) #追加
  end

  def edit
    @user = User.find(params[:id]) #追記
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id]) #追加
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully." #users.1は余分に引数を渡しているときにこのように表示される今回はshowのpathを記入
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image) #titleカラム削除
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

