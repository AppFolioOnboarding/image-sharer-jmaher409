class Image < ApplicationRecord
  include ActiveModel::Validations

  acts_as_taggable

  validates_url :url, url: true
end
