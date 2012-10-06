Ruby Version
============

**ruby-version** wraps the `RUBY_VERSION` and `RUBY_ENGINE` constant and 
allows version number matching on all major Ruby platforms. Usage is simple:

    require "ruby-version"
    
    Ruby::Version > "1.8.7"
    # will return true for 1.9.2 and false for 1.8.3
    
Or for the ruby engine name:

    Ruby::Engine::NAME
    # will return "ruby" typically (works on 1.8 too of sure)
    
    Ruby::Engine == "ruby"    # or something else
    # will return appropriate boolean
    
[![Build Status](https://secure.travis-ci.org/martinkozak/ruby-version.png)](http://travis-ci.org/martinkozak/ruby-version)

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][9] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.

Copyright
---------

Copyright &copy; 2011-2012 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[9]: http://github.com/martinkozak/ruby-version/issues
[10]: http://www.martinkozak.net/
