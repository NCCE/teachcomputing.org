module ProgrammesHelper

  def certificate_number(certificate_number, passed_date)
    "#{passed_date.strftime('%Y%m')}-#{sprintf('%03d', certificate_number || 0)}"
  end

  def index_to_word_ordinal(index = 0)
    to_word_ordinal((index || 0) + 1)
  end

  def to_word_ordinal(number)
    index = number || 0;
    ordinals = %w[none first second third fourth fifth sixth seventh eighth ninth tenth]
    return ordinals[index] if index <= ordinals.length && index > 0
    ActiveSupport::Inflector::ordinalize(index)
  end
end
