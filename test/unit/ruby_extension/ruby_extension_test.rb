#require 'test/unit'
#require 'rubygems'
#require 'uri'
##require 'active_support/core_ext'
#require 'active_support'
#require 'active_support/test_case'
#
#$:.unshift "#{File.dirname(__FILE__)}/../lib"
#require "#{File.dirname(__FILE__)}/../rails/init"

require 'test_helper'

class RubyExtensionTest < ActiveSupport::TestCase

#	Nil

	test "should split nil and return empty array" do
		assert_equal [], nil.split()
	end

	test "should not include anything" do
		assert_equal false, nil.include?(1)
	end

#	Array

	test "should arrange array" do
		assert_equal ["c", "a", "b"], ['a','b','c'].arrange([2,0,1])
	end

	test "should drop empty strings from array" do
		x = [0,1,'zero','one','']
		y = x.drop_blanks!
		assert_equal [0,1,'zero','one'], x
		assert_equal [0,1,'zero','one'], y
	end

	test "should drop nils from array" do
		x = [0,1,'zero','one',nil]
		y = x.drop_blanks!
		assert_equal [0,1,'zero','one'], x
		assert_equal [0,1,'zero','one'], y
	end

	test "should capitalize! all strings in existing array" do
		x = ['foo','bar']
		y = x.capitalize!
		assert_equal ['Foo','Bar'], x
		assert_equal ['Foo','Bar'], y
	end

	test "should capitalize all strings in new array" do
		x = ['foo','bar']
		y = x.capitalize
		assert_equal ['foo','bar'], x		#	no change to original
		assert_equal ['Foo','Bar'], y
	end

	test "should downcase all strings in new array" do
		x = ['FOO','BAR']
		y = x.downcase
		assert_equal ['FOO','BAR'], x		#	no change to original
		assert_equal ['foo','bar'], y
	end

	test "should numericize/digitize" do
		x = ['foo', 'bar', 0, '42', '-0.4', nil]
		y = x.numericize
		assert_equal ['foo', 'bar', 0, '42', '-0.4', nil], x
		assert_equal [0.0, 0.0, 0.0, 42, -0.4, 0.0], y
	end

	test "should compute sum" do
		x = ['foo', 'bar', 0, '42', '-0.4', nil]
		y = x.numericize.sum
		assert_equal ['foo', 'bar', 0, '42', '-0.4', nil], x
		assert_equal 41.6, y
	end

	test "should compute average" do
		x = [ 1, 1, 4 ]
		y = x.average
		assert_equal 2.0, y
	end

	test "should compute median" do
		x = [ 1, 1, 4 ]
		y = x.median
		assert_equal 1, y
	end

	test "should swap values based on indexes" do
		x = %w( apple banana orange )
		y = x.swap_indexes(0,2)
		assert_equal %w( apple banana orange ), x
		assert_equal %w( orange banana apple ), y
	end

	test "should swap! values based on indexes" do
		x = %w( apple banana orange )
		y = x.swap_indexes!(0,2)
		assert_equal %w( orange banana apple ), x
		assert_equal %w( orange banana apple ), y
	end

	test "should find first index via argument" do
		x = %w( apple banana orange )
		assert_equal 1, x.first_index('banana')
	end

	test "should find first index via block" do
		x = %w( apple banana orange )
		assert_equal 1, x.first_index{|i| i == 'banana'}
	end

	test "should return nil for first index with empty array" do
		assert_nil [].first_index('banana')
	end

	test "should return nil for first index with no match" do
		x = %w( apple banana orange )
		assert_nil x.first_index('pineapple')
	end


	#	to_boolean / to_b / true? / false?
	test "should be true with all true" do
		assert [true, 'true', 1, '1', 't'].to_boolean
		assert [true, 'true', 1, '1', 't'].to_b

		assert  [true, 'true', 1, '1', 't'].true?
		assert ![true, 'true', 1, '1', 't'].false?
	end

	test "should be false with one false" do
		assert ![true, 'true', 1, '1', 't', 'f'].to_boolean
		assert ![true, 'true', 1, '1', 't', 'f'].to_b

		assert [true, 'true', 1, '1', 't', 'f'].true?
		assert [true, 'true', 1, '1', 't', 'f'].false?
	end

	test "should be false when empty" do
		assert ![].to_boolean
		assert ![].to_b
		assert ![].true?
		assert ![].false?
	end

	#	true_xor_false?
	test "should be true_xor_false? with only true" do
		assert [true].true_xor_false?
		assert ['true'].true_xor_false?
		assert [1].true_xor_false?
		assert ['1'].true_xor_false?
		assert ['t'].true_xor_false?
	end

	test "should be true_xor_false? with only false" do
		assert [false].true_xor_false?
		assert ['false'].true_xor_false?
		assert [0].true_xor_false?
		assert ['0'].true_xor_false?
		assert ['f'].true_xor_false?
	end

	test "should not be true_xor_false? with both true and false" do
		assert ![true,false].true_xor_false?
		assert !['true','false'].true_xor_false?
		assert ![1,0].true_xor_false?
		assert !['1','0'].true_xor_false?
		assert !['t','f'].true_xor_false?
	end


#	String

	test "should convert url query string to hash" do
		h = {'foo' => '1', 'bar' => '2'}
		assert_equal h, "foo=1&bar=2".to_params_hash
	end

	test "should return self in response to uniq" do
		assert_equal "foobar", "foobar".uniq
	end

#	Integer

	test "should return 5 factorial" do
		assert_equal 120, 5.factorial
	end

	test "should return 0 factorial" do
		assert_equal 0, 0.factorial
	end

	test "should return -3 factorial" do
		assert_equal -3, -3.factorial
	end


#	Hash

	#	delete_keys_matching!(regex)

	#	delete_keys!(*keys)

	#	dig
	test "should return Gold when all keys match dig" do
		h = { :a => { :b => { :c => 'Gold' } } }
		assert_equal 'Gold', h.dig(:a,:b,:c)
	end

	test "should return nil when no key matching dig" do
		h = { :a => { :b => { :c => 'Gold' } } }
		assert_nil h.dig('a')
		assert_nil h.dig(:a,:b,:d)
		assert_nil h.dig(:d,:e,:f)
	end

	#	deep_stringify_keys
	test "should return hash with stringified keys" do
		h = { :a => { :b => { :c => 'Gold' } } }
		assert  h.has_key?(:a)
		assert !h.has_key?('a')
		assert  h[:a].has_key?(:b)
		assert !h[:a].has_key?('b')
		assert  h[:a][:b].has_key?(:c)
		assert !h[:a][:b].has_key?('c')
		s = h.deep_stringify_keys
		assert !s.has_key?(:a)
		assert  s.has_key?('a')
		assert !s['a'].has_key?(:b)
		assert  s['a'].has_key?('b')
		assert !s['a']['b'].has_key?(:c)
		assert  s['a']['b'].has_key?('c')
	end

#	Object

	#	true?
	test "should be true? when true" do
		assert 1.true?
		assert '1'.true?
		assert true.true?
		assert 'tRUe'.true?
		assert 'true'.true?
		assert 't'.true?
	end

	#	false?
	test "should be false? when false" do
		assert !nil.false?
		assert 0.false?
		assert '0'.false?
		assert false.false?
		assert 'fALsE'.false?
		assert 'false'.false?
		assert 'f'.false?
	end

	#	to_boolean
	test "should return true when true" do
		assert 1.to_boolean
		assert '1'.to_boolean
		assert true.to_boolean
		assert 'tRUe'.to_boolean
		assert 'true'.to_boolean
		assert 't'.to_boolean
	end

	test "should return false when false" do
		assert !nil.to_boolean
		assert !0.to_boolean
		assert !'0'.to_boolean
		assert !false.to_boolean
		assert !'fALsE'.to_boolean
		assert !'false'.to_boolean
		assert !'f'.to_boolean
	end

end
