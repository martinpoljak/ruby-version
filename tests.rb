#!/usr/bin/env ruby
# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

$:.push("./lib")

require "rubygems"
require "rspec"

require "simplecov"
SimpleCov.start

require "ruby-version"

###

LOWER = :"1.1.3"
CURRENT = RUBY_VERSION.to_sym
HIGHER = :"4.0.1"

###

describe Ruby::Engine do
    specify "NAME shoud be something reasonable" do
        not ['ruby', 'jruby', 'rbx'].include? Ruby::Engine::NAME
    end
    it "shoud be comparable" do
        Ruby::Engine == "foo"
        true
    end
end

describe Ruby::Version, "-- algebraic comparsion operators" do
    
    context "against higher version" do
        it "should be lower" do
            Ruby::Version < HIGHER
        end
        it "should be lower or equal" do
            Ruby::Version <= HIGHER
        end
        it "shouldn't be equal" do
            not Ruby::Version == HIGHER
        end
        it "should be higher or equal" do
            Ruby::Version >= HIGHER
        end
        it "should be higher" do
            Ruby::Version > HIGHER
        end
    end
    
    context "against current version" do
        it "shouldn't be lower" do
            not Ruby::Version < CURRENT
        end
        it "should be lower or equal" do
            Ruby::Version <= CURRENT
        end
        it "should be equal" do
            Ruby::Version == CURRENT
        end
        it "should be higher or equal" do
            Ruby::Version >= CURRENT
        end
        it "shouldn't be higher" do
            not Ruby::Version > HIGHER
        end
    end
    
    context "against lower version" do
        it "should be lower" do
            Ruby::Version < LOWER
        end
        it "should be lower or equal" do
            Ruby::Version <= LOWER
        end
        it "shouldn't be equal" do
            not Ruby::Version == LOWER
        end
        it "shouldn't be higher or equal" do
            not Ruby::Version >= LOWER
        end
        it "shouldn't be higher" do
            not Ruby::Version > LOWER
        end
        
    end
end

describe Ruby::Version, "-- fuzzy operators" do
    
    context "against higher version" do
        specify "#<=> should return -1" do
            (Ruby::Version <=> HIGHER) == -1
        end
        specify "#compare should return -1" do
            Ruby::Version::compare(HIGHER) == -1
        end
    end
    
    context "against current version" do
        specify "#<=> should return 0" do
            (Ruby::Version <=> CURRENT) == 0
        end
        specify "#compare should return 0" do
            Ruby::Version::compare(CURRENT) == 0
        end
    end
    
    context "against lower version" do
        specify "#<=> should return 1" do
            (Ruby::Version <=> LOWER) == 1
        end
        specify "#compare should return 1" do
            Ruby::Version::compare(LOWER) == -1
        end
    end
end

describe Ruby::Version do

    specify "TOKENS constant content the same as broking result" do
        Ruby::Version::TOKENS == Ruby::Version::broke(RUBY_VERSION)
    end
    specify "VERSION constant should be equal to RUBY_VERSION" do
        Ruby::Version::VERSION == RUBY_VERSION
    end
    specify "broking components should equal to version string components" do
        Ruby::Version::broke("1.2.3") == [1, 2, 3]
    end
    
end
