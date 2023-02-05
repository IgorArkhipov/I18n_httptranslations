# frozen_string_literal: true

require 'i18n'
require 'psych'
require 'httpx/adapters/faraday'

module I18n
  module Backend
    class HttpTranslations < I18n::Backend::Simple
      attr_reader :endpoint, :connection

      def initialize
        @endpoint = 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/'
        @connection = Faraday.new(url: @endpoint,
                                  ssl: { verify: false },
                                  request: { timeout: 600, open_timeout: 600 }) do |faraday|
                                    faraday.adapter :httpx, resolver_options: { cache: false }
                                  end
        super
      end

      module Implementation
        include Base

        def init_translations
          @translations = load_http_translations
          @initialized = true
        end

        def translations(do_init: false)
          init_translations if do_init || !initialized?
          @translations ||= {}
        end

        def translate(locale, key, options = {})
          result = catch(:exception) { super }

          if result.is_a?(I18n::MissingTranslation)
            throw(:exception, result)
          else
            result
          end
        end

        protected

        def load_http_translations
          response = connection.send(:get, "#{endpoint}#{I18n.locale}.yml")
          Psych.safe_load(response.body, permitted_classes: [Symbol], symbolize_names: true) if response.success?
        rescue Faraday::Error
          raise I18n::MissingTranslation
        end
      end

      include Implementation
    end
  end
end
