# frozen_string_literal: true

require 'i18n'
require_relative 'i18n/http_translations'
require_relative 'phrase/version'

module Phrase
  I18n.backend = I18n::Backend::Chain.new(I18n::Backend::HttpTranslations.new, I18n::Backend::Simple.new)
end
