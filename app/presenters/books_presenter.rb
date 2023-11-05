class BooksPresenter < SimpleDelegator
  include ActiveSupport::NumberHelper

  def price
    number_to_currency(super / 100)
  end

  def authors
    super.map { |author| "#{author.full_name}" }.join(', ')
  end
end
