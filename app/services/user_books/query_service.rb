module UserBooks
  class QueryService

    def initialize(params)
      @finish_date = params[:finish_date]
      @user = params[:user]
    end

    def search
      if @finish_date
        return UserBook.finished(@user)
      else
        return UserBook.to_read(@user)
      end
    end

    private

    attr_reader :params
  end
end