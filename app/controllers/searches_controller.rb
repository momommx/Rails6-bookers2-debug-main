class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.all
    @books = Book.all
    @word = params[:word]
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
