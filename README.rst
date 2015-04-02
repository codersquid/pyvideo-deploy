======
README
======

Bits needed for deploment.

Setup
=====

1. ``mkvirtualenv pyvideodeploy``
2. ``pip install -r requirements.txt``
3. run ``make setup``
4. get a copy of ``secret.yml``


Deploy
======

Deploy to dev.pyvideo.org::

  make dev

Make sure the site is working.

Deploy to pyvideo.org::

  make prod
