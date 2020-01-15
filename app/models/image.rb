class Image < ApplicationRecord
  include ActiveModel::Validations

  validates_url :url, url: true
end
