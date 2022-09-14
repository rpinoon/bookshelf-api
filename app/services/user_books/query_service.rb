module UserBooks
  class QueryService

    def initialize(params)
      @finish_date = params[:finish_date]
      @user = params[:user]
    end

    def search
      @finish_date ? UserBook.finished(@user) : UserBook.to_read(@user)
    end

    private

    attr_reader :params
  end
end