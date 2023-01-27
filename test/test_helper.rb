# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'phrase'

require 'minitest/autorun'

module I18n
  class TestCase < Minitest::Test
    def setup
      I18n.enforce_available_locales = false
      I18n.available_locales = []
      I18n.locale = :en
      I18n.default_locale = :en
      I18n.load_path = []
    end

    def teardown
      I18n.enforce_available_locales = false
      I18n.available_locales = []
      I18n.locale = :en
      I18n.default_locale = :en
      I18n.load_path = []
      I18n.backend = nil
    end

    def store_translations(locale, data)
      I18n.backend.store_translations(locale, data)
    end

    def locales_dir
      "#{File.dirname(__FILE__)}/test_data/locales"
    end
  end
end
