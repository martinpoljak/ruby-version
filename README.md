Ruby Version
============

**ruby-version** wraps the `RUBY_VERSION` constant and allows version
number matching. Usage is simple:

    require "ruby-version"
    
    Ruby::Version > "1.8.7"
    # will return true for 1.9.2 and false for 1.8.3

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

Copyright &copy; 2011 [Martin Kozák][10]. See `LICENSE.txt` for
further details.

[9]: http://github.com/martinkozak/ruby-version/issues
[10]: http://www.martinkozak.net/
