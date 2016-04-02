require 'sjs'
require 'lock_jar'
LockJar.load(resolve: true)

java_import 'com.tobedevoured.json.SimpleStream'
java_import 'java.util.Map'
java_import 'java.util.List'

module Sjs
  class SimpleStream
    StreamError = Class.new(::StandardError)

    attr_reader :parser

    # @param buffer [Integer] buffer amount until json is parsed
    def initialize(buffer = 8092)
      @parser = ::SimpleStream.new(buffer)
    end

    # @param raw_json [String] raw_json
    def stream(raw_json)
      begin
        entities = parser.stream(raw_json.to_s)
        transform_to_ruby(entities)
      rescue => ex
        raise StreamError.new(ex)
      end
    end

    # @param callback [Block] Block that will yield the parsed entities
    def apply_callback(&callback)
      parser_callback = proc do |data|
        callback.call(transform_to_ruby(entities))
      end

      parser.setCallback(parser_callback)
    end

    # @param url [String]
    # @param timeout [Integer] seconds of inactivitiy until connection times out, defaults to 10.
    # @param callback [Block] Block that will yield the parsed entities
    def stream_from_url(url, timeout = 10, &callback)
      apply_callback(&callback)
      parser.streamFromUrl(url, timeout)
    rescue => ex
      raise StreamError.new(ex)
    end

    def reset!
      parser.reset
    rescue => ex
      raise StreamError.new(ex)
    end

    def flush!
      transform_to_ruby(parser.flush)
    rescue => ex
      raise StreamError.new(ex)
    end

    private

    # Converts Java Maps and Lists to Ruby
    def transform_to_ruby(data)
      case data
      when Array, List
        transformed_data = data.to_a.map do |v|
          transform_to_ruby(v)
        end
      when Map
        transformed_data = Naether::Java.convert_to_ruby_hash(data)
        transformed_data.each do |k, v|
          transformed_data[k] = transform_to_ruby(v)
        end
      when Hash
        transformed_data = data
        transformed_data.each do |k, v|
          transformed_data[k] = transform_to_ruby(v)
        end
      else
        transformed_data = data
      end

      transformed_data
    end
  end
end
