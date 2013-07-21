require 'pstore'
require 'oj'

class Oj::Store < ::PStore
  
  attr_reader :obtions

  def initialize(file_name, options= {})
    super(file_name, options.fetch(:thread_safe, false))
    @options= options
  end

  def dump(obj)
    Oj.dump(obj, @options)
  end

  def load(content)
    content.size.zero? ? {} : Oj.object_load(content, @options)
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
  
  autoload :VERSION, File.expand_path('../store/version', __FILE__)

end
