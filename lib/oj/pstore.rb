require 'oj'
require 'pstore'

module Oj
  class PStore < ::PStore

    def initialize(file_name, options= {})
      @opt= options
      super(file_name, options.fetch(:thread_safe, false))
    end

    def dump(table)
      Oj.dump(table, @opt)
    end

    def load(content)
      table= Oj.load(content, @opt)
      table == false ? {} : table
    end

    def marshal_dump_supports_canonical_option?
      false
    end

    def empty_marshal_data
      EMPTY_MARSHAL_DATA
    end

    def empty_marshal_checksum
      EMPTY_MARSHAL_CHECKSUM
    end

    private

    EMPTY_MARSHAL_DATA = Oj.dump({}).freeze
    EMPTY_MARSHAL_CHECKSUM = Digest::MD5.digest(EMPTY_MARSHAL_DATA)
    
    autoload :VERSION, File.expand_path('../pstore/version', __FILE__)

  end
end
