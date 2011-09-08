# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/numeric"  # >= 0.16.0
require "hash-utils/object"   # >= 0.17.0

##
# Outer wrapper for the {Ruby::Version} module.
#

module Ruby
    
    ##
    # Wraps the +RUBY_VERSION+ constant and provides some handling
    # such as comparing.
    #
    
    module Version
    
        ##
        # Contains the Ruby version identification in frozen string.
        # It's content is equal to the +RUBY_VERSION+ constant.
        #
    
        VERSION = RUBY_VERSION.dup.freeze
        
        ##
        # Holds comparign cache.
        #
        
        @cache
        
        ##
        # Higher or equal operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.>=(value)
            __cache(:">=", value) do
                __compare(value, false, true, true)
            end
        end
        
        ##
        # Lower or equal operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.<=(value)
            __cache(:"<=", value) do
                __compare(value, true, false, true)
            end
        end
        
        ##
        # Lower operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.<(value)
            __cache(:<, value) do
                __compare(value, true, false, false)
            end
        end
        
        ##
        # Higher operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.>(value)
            __cache(:>, value) do
                __compare(value, false, true, false)
            end
        end
        
        ##
        # Equality operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.==(value)
            __cache(:"==", value) do
                __compare(value, false, false, true)
            end
        end
        
        ##
        # Compares version strings.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +1+ if this one is higher, +-1+ if lower and +0+ otherwise
        #
        
        def self.compare(value)
            __cache(:compare, value) do
                __compare(value, -1, 1, 0)
            end
        end
        
        ##
        # Brokes string identifier to numeric tokens in array.
        #
        # @param [String, Symbol] value version identifier
        # @return [Array] array of tokens
        #
        
        def self.broke(string)
            string.to_s.split(".").map! { |i| i.to_i }
        end
        
        
        ##
        # Contents frozen tokens array of the current ruby version.
        # @see VERSION
        #
        
        TOKENS = self::broke(self::VERSION).freeze
        
        ##
        # Universal comparing routine for all type of (in)equalities.
        #
        
        private
        def self.__compare(value, lower, higher, equal)
            if not value.array?
                value = self.broke(value.to_s)
            end
            
            self::TOKENS.each_index do |i|
                case self::TOKENS[i].to_i.compare(value[i].to_i)
                    when -1
                        return lower
                    when 1
                        return higher
                end
            end
            
            return equal
        end
        
        ##
        # Universal cache routine.
        #
        
        private
        def self.__cache(operation, value, &block)
            value = value.to_sym if value.string?
            
            if @cache.nil?
                @cache = Hash::new { |dict, key| dict[key] = { } }
            end
            
            if not @cache[operation].has_key? value
                @cache[operation][value] = block.call()
            end

            @cache[operation][value]
        end
        
    end
end

