# frozen_string_literal: true

require 'i18n/backend/base'
require 'psych'
require 'httpx/adapters/faraday'

module I18n
  module Backend
    class HttpTranslations
      attr_reader :locale, :endpoint, :connection

      def initialize
        @locale = I18n.locale
        # @endpoint = "#{ENV['BASE_TRANSLATIONS_URL']}/translations"
        @endpoint = 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/'
        @connection = Faraday.new(url: @endpoint,
                                  ssl: { verify: false },
                                  request: { timeout: 600, open_timeout: 600 }) do |faraday|
                                    faraday.adapter :httpx, resolver_options: { cache: false }
                                  end
        reload!
      end

      module Implementation
        include Base
        include Flatten

        def reload!
          @translations = nil

          self
        end

        def initialized?
          !@translations.nil?
        end

        def init_translations
          @translations = load_http_translations
        end

        def translations(do_init: false)
          init_translations if do_init || !initialized?
          @translations ||= {}
        end

        def available_locales
          I18n::Backend::Simple.new.available_locales
        end

        protected

        def load_http_translations
          response = connection.send(:get, "#{endpoint}#{locale}.yml")

          Psych.safe_load(response.body, permitted_classes: [Symbol], symbolize_names: true) if response.success?
        rescue Faraday::Error
          nil
        end
      end

      include Implementation
    end
  end
end
