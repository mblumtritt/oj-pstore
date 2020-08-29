require 'minitest/autorun'
require_relative '../lib/oj/store'

class OjStoreTest < Minitest::Test

  class SampleData
    attr_accessor :name, :number
  end

  def setup
    @store_file = "oj-store.tmp.#{Process.pid}"
    @store_file2 = "oj-store.2.tmp.#{Process.pid}"
    @store = Oj::Store.new(@store_file)
  end

  def teardown
    File.file?(@store_file) and File.unlink(@store_file) rescue nil
    File.file?(@store_file2) and File.unlink(@store_file2) rescue nil
  end

  def test_opening_new_file_in_readonly_mode_should_result_in_empty_values
    @store.transaction(true) do
      assert_nil @store[:foo]
      assert_nil @store[:bar]
    end
  end

  def test_opening_new_file_in_readwrite_mode_should_result_in_empty_values
    @store.transaction do
      assert_nil @store[:foo]
      assert_nil @store[:bar]
    end
  end

  def test_data_should_be_loaded_correctly_when_in_readonly_mode
    @store.transaction do
      @store[:foo] = 'bar'
    end
    @store.transaction(true) do
      assert_equal 'bar', @store[:foo]
    end
  end

  def test_data_should_be_loaded_correctly_when_in_readwrite_mode
    @store.transaction do
      @store[:foo] = 'bar'
    end
    @store.transaction do
      assert_equal 'bar', @store[:foo]
    end
  end

  def test_changes_after_commit_are_discarded
    @store.transaction do
      @store[:foo] = 'bar'
      @store.commit
      @store[:foo] = 'baz'
    end
    @store.transaction(true) do
      assert_equal 'bar', @store[:foo]
    end
  end

  def test_changes_are_not_written_on_abort
    @store.transaction do
      @store[:not_written] = 'just a value'
      @store.abort
    end
    @store.transaction(true) do
      assert_nil @store[:not_written]
    end
  end

  def test_writing_inside_readonly_transaction_raises_error
    assert_raises(PStore::Error) do
      @store.transaction(true) do
        @store[:foo] = 'bar'
      end
    end
  end

  def test_thread_safe
    assert_raises(PStore::Error) do
      flag = false
      Thread.new do
        @store.transaction do
          @store[:foo] = 'bar'
          flag = true
          sleep 1
        end
      end
      until flag
        # nop
      end
      @store.transaction {}
    end
    begin
      pstore = PStore.new(@store_file2,true)
      flag = false
      Thread.new do
        pstore.transaction do
          pstore[:foo] = 'bar'
          flag = true
          sleep 1
        end
      end
      until flag
        # nop
      end
      pstore.transaction do
        assert(pstore[:foo] == 'bar')
      end
    end
  end

  def test_nested_transaction_raises_error
    assert_raises(PStore::Error) do
      @store.transaction { @store.transaction { } }
    end
    pstore = PStore.new(@store_file2, true)
    assert_raises(PStore::Error) do
      pstore.transaction { pstore.transaction { } }
    end
  end

  def test_extended_data
    array = [1,2,3,4,'a','b','c']
    hash = {a: 42, b: :c, d: 'e', 'f' => 4711}
    s = SampleData.new
    s.name = 'a name'
    s.number = 12345678
    @store.transaction do
      @store[:string] = 'a simple string'
      @store[:number] = 42.21
      @store[:array] = array
      @store[:hash] = hash
      @store[:sample] = s
    end
    @store.transaction(true) do
      assert_equal 'a simple string', @store[:string]
      assert_equal 42.21, @store[:number]
      assert_equal array, @store[:array]
      assert_equal hash, @store[:hash]
      assert_equal s.class, @store[:sample].class
      assert_equal s.name, @store[:sample].name
      assert_equal s.number, @store[:sample].number
    end
  end
end
