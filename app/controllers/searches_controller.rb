class SearchesController < ApplicationController
  # フォームで入力された情報をここで受け取る
  def search
    @range = params[:range]
    # ユーザーから探す処理(user.rbのlooksメソッドを使用)
    if @range == "User"
      @users = User.looks(params[:search], params[:word]) #looksメソッドを使い、検索結果を@usersに代入
      # 投稿から探す処理(book.rbのlooksメソッドを使用)
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
  
  def searches
  end
end
