FROM python:3.6-slim-stretch

# install git
RUN apt-get update && apt-get -y install git

# can pip install directly from git because we now have wheels for pyeebls
RUN pip install --no-cache-dir git+https://github.com/waqasbhatti/astrobase

# install ipython that will have astrobase available
RUN pip install --no-cache-dir ipython

# include the JPL ephem file so this is self-contained
RUN python -c "from astrobase import timeutils"

# setup the work directory
WORKDIR /astrobase

# the default command to run if invoked with docker run --rm -it or similar
# this just starts ipython
# to make local files in the current directory available to the docker
# container, use something like:
# docker run --rm -it -v `pwd`:/astrobase/work <container id>
CMD ["ipython"]