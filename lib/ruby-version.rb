# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "hash-utils/numeric"

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
    
        VERSION = RUBY_VERSION.freeze
        
        ##
        # Higher or equal operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.>=(value)
            __compare(value, false, true, true)
        end
        
        ##
        # Lower or equal operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.<=(value)
            __compare(value, true, false, true)
        end
        
        ##
        # Lower operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.<(value)
            __compare(value, true, false, false)
        end
        
        ##
        # Higher operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.>(value)
            __compare(value, false, true, false)
        end
        
        ##
        # Equality operator.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +true+ if yes, +false otherwise
        #
        
        def self.==(value)
            __compare(value, false, false, true)
        end
        
        ##
        # Compares version strings.
        #
        # @param [String, Symbol, Array] value version identifier
        # @return [Boolean] +1+ if this one is higher, +-1+ if lower and +0+ otherwise
        #
        
        def self.compare(value)
            __compare(value, -1, 1, 0)
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
            if not value.kind_of? Array
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
        
    end
end

