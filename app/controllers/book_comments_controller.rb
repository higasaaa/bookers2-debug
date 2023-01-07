class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer #特定の処理後、遷移元のURLに戻る
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy #find_by条件を指定して最初の1件を取得存在しない場合はnil
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
