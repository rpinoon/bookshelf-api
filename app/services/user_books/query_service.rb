module UserBooks
  class QueryService

    def initialize(params)
      @finish_date = params[:finish_date]
      @user = params[:user]
    end

    def search
      list =  @finish_date ? UserBook.finished(@user) : UserBook.to_read(@user)
      new_list = []
      id_array = list.pluck(:id)
      rating_array = list.pluck(:rating)
      notes_array = list.pluck(:notes)

      options = { include: [:book] }
      books = serialize_data(list)

      books.each_with_index do |book, i|
        new_book = book.dup
        new_book[:user_book_id] = id_array[i]
        new_book[:user_book_rating] = rating_array[i]
        new_book[:user_book_notes] = notes_array[i]
        new_list << new_book
      end
      
      return new_list
    end

    private

    attr_reader :params

    def serialize_data(data)
      options = { include: [:book] }
      return UserBookSerializer.new(data, options).serializable_hash[:included].pluck(:attributes)
    end
  end
end