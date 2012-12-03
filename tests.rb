#!/usr/bin/env ruby
# encoding: utf-8
# (c) 2011-2012 Martin Kozák (martinkozak@martinkozak.net)

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
        ['ruby', 'jruby', 'rbx'].include?(Ruby::Engine::NAME).should be_true
    end
    it "shoud be comparable" do
        (Ruby::Engine == "foo").should be_false
    end
end

describe Ruby::Version, "-- algebraic comparsion operators" do
    
    context "against higher version" do
        it "should be lower" do
            (Ruby::Version < HIGHER).should be_true
        end
        it "should be lower or equal" do
            (Ruby::Version <= HIGHER).should be_true
        end
        it "shouldn't be equal" do
            (Ruby::Version == HIGHER).should be_false
        end
        it "should be higher or equal" do
            (Ruby::Version >= HIGHER).should be_false
        end
        it "should be higher" do
            (Ruby::Version > HIGHER).should be_false
        end
    end
    
    context "against current version" do
        it "shouldn't be lower" do
            (Ruby::Version < CURRENT).should be_false
        end
        it "should be lower or equal" do
            (Ruby::Version <= CURRENT).should be_true
        end
        it "should be equal" do
            (Ruby::Version == CURRENT).should be_true
        end
        it "should be higher or equal" do
            (Ruby::Version >= CURRENT).should be_true
        end
        it "shouldn't be higher" do
            (Ruby::Version > HIGHER).should be_false
        end
    end
    
    context "against lower version" do
        it "should be lower" do
            (Ruby::Version < LOWER).should be_false
        end
        it "should be lower or equal" do
            (Ruby::Version <= LOWER).should be_false
        end
        it "shouldn't be equal" do
            (Ruby::Version == LOWER).should be_false
        end
        it "shouldn't be higher or equal" do
            (Ruby::Version >= LOWER).should be_true
        end
        it "shouldn't be higher" do
            (Ruby::Version > LOWER).should be_true
        end
        
    end
end

describe Ruby::Version, "-- fuzzy operators" do
    
    context "against higher version" do
        specify "#<=> should return -1" do
            (Ruby::Version <=> HIGHER).should eq(-1)
        end
        specify "#compare should return -1" do
            Ruby::Version::compare(HIGHER).should eq(-1)
        end
    end
    
    context "against current version" do
        specify "#<=> should return 0" do
            (Ruby::Version <=> CURRENT).should eq(0)
        end
        specify "#compare should return 0" do
            Ruby::Version::compare(CURRENT).should eq(0)
        end
    end
    
    context "against lower version" do
        specify "#<=> should return 1" do
            (Ruby::Version <=> LOWER).should eq(1)
        end
        specify "#compare should return 1" do
            Ruby::Version::compare(LOWER).should eq(1)
        end
    end
end

describe Ruby::Version do

    specify "TOKENS constant content the same as broking result" do
        Ruby::Version::TOKENS.should eq(Ruby::Version::broke(RUBY_VERSION))
    end
    specify "VERSION constant should be equal to RUBY_VERSION" do
        Ruby::Version::VERSION.should eq(RUBY_VERSION)
    end
    specify "broking components should equal to version string components" do
        Ruby::Version::broke("1.2.3").should eq([1, 2, 3])
    end
    
end
