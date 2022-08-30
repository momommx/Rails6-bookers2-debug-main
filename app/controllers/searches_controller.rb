class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.all
    @books = Book.all
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elseif
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
