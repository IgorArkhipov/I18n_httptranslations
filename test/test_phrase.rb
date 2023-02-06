# frozen_string_literal: true

require 'test_helper'
require 'phrase'

class I18nHttpTranslationsTest < I18n::TestCase
  def setup
    I18n::Backend::HttpTranslations.endpoint = 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/'
  end

  def test_that_it_has_a_version_number
    refute_nil Phrase::VERSION
  end

  def test_raises_error_when_endpoint_not_configured
    I18n::Backend::HttpTranslations.endpoint = nil

    error = assert_raises(StandardError) do
      I18n::Backend::HttpTranslations.new
    end

    assert_equal(I18n::Backend::HttpTranslations::ENDPOINT_MISSING, error.message)
  end

  def test_that_actual_backend_is_custom_one
    I18n.backend = I18n::Backend::HttpTranslations.new

    assert_equal I18n::Backend::HttpTranslations, I18n.backend.class
  end

  def test_that_available_locales_returns_uniq_locales
    I18n.backend = I18n::Backend::HttpTranslations.new

    store_translations(:en, foo: { bar: 'bar' })
    store_translations(:en, foo: { baz: 'baz' })
    store_translations(:de, foo1: 'foo')
    store_translations(:de, foo2: 'foo')

    available_locales = I18n.backend.available_locales

    assert_equal 2, available_locales.size
    assert_includes available_locales, :en
    assert_includes available_locales, :de
  end

  def test_initially_unitinitialized
    I18n.backend = I18n::Backend::HttpTranslations.new

    refute_predicate I18n.backend, :initialized?

    I18n.backend.send(:init_translations)

    assert_predicate I18n.backend, :initialized?
  end

  def test_initialized_after_reload
    I18n.backend = I18n::Backend::HttpTranslations.new

    I18n.backend.reload!

    refute_predicate I18n.backend, :initialized?

    I18n.backend.send(:init_translations)

    assert_predicate I18n.backend, :initialized?
  end

  def test_fall_back_to_simple_backend
    I18n.backend = I18n::Backend::Chain.new(I18n::Backend::HttpTranslations.new, I18n::Backend::Simple.new)
    I18n.load_path = Dir[File.join(locales_dir, '*.yml')]

    assert_equal 'test text', I18n.translate(:local)
  end

  def test_setting_custom_endpoint
    I18n.available_locales = %i[en de]
    I18n.locale = :de
    I18n::Backend::HttpTranslations.endpoint = 'https://raw.githubusercontent.com/leapcode/leap_web/master/config/locales/'
    I18n.backend = I18n::Backend::HttpTranslations.new

    assert_equal 'Sind Sie sicher? Diese Änderung kann nicht rückgängig gemacht werden.', I18n.translate(:are_you_sure)
  end
end
