class HtmlValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if options.key?(:presence) && blank?(value)
        record.errors.add(attribute, error_message)
      end
    end

    private

    def blank?(value)
      value.blank? || Nokogiri::HTML(value).
        search('//text()').
        map(&:text).
        join.
        blank?
    end

    def error_message
      options.fetch(:messages, :blank)
    end
  end
