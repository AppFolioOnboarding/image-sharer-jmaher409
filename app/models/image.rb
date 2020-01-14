class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    print 'value' + value
    record.errors[:url] << 'invalid' unless valid_url(value)
  end

  private

  def valid_url(url)
    print 'in valid_url urL=' + url
    parsed = URI.parse(url)
    parsed.is_a?(URI::HTTP) && !parsed.host.nil?
  rescue URI::InvalidURIError
    print 'invalid Url'
    false
  end
end

class Image < ApplicationRecord
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  validates_with UrlValidator, attributes: [:url]
end
