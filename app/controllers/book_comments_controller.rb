class BookCommentsController < ApplicationController
  
  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    # app/views/book_comments/create.js.erbを参照する
  end
  
  def destroy
   @book = Book.find(params[:book_id])
   BookComment.find(params[:id]).destroy
   # app/views/book_comments/destroy.js.erbを参照する
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
