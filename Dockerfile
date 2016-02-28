# OpenCV lab and testing environment

# Build image and maintainer
FROM centos
MAINTAINER wcbullington

# Dockerfile environment variables initialized
ENV OPENCV_PREFIX /opt/opencv
ENV OPENCV_SRC_DIR $OPENCV_PREFIX/src
ENV OPENCV_VERSION 2.4.11
ENV OPENCV_ARCHIVE_URL https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.tar.gz

# Update system and install OpenCV dependencies
RUN yum update -y && yum install -y \
    epel-release \
    make \
    cmake \
    git \
    gcc-c++ \
    rsync \
    && yum clean all

# Install optional OpenCV dependencies
RUN yum install -y \
    python-devel \
    numpy \
    libgtk2.0-devel \
    pkgconfig \
    libavcodec-devel \
    libavformat-devel \
    libswscale-devel \
    libtbb2 \
    libtbb-devel \
    libjpeg-devel \
    libpng-devel \
    libtiff-devel \
    libjasper-devel \
    libdc1394-22-devel \
    && yum clean all

# Install Imagemagick and Nodejs
RUN yum install -y \
    ImageMagick \
    nodejs \
    npm \
    && yum clean all

# Install Bower
RUN npm install -g \
    bower

# Install Nodejs modules
RUN npm install -g \
    nodemon \
    grunt \
    grunt-cli

# Create working directories, choose build options, and build OpenCV from source
RUN mkdir -p $OPENCV_SRC_DIR \
    && curl -sL $OPENCV_ARCHIVE_URL | tar xz -C $OPENCV_SRC_DIR \
    && cd $OPENCV_SRC_DIR/opencv-$OPENCV_VERSION \
    && cmake . \
       -DCMAKE_INSTALL_PREFIX=$OPENCV_PREFIX \
       -DBUILD_DOCS=OFF \
       -DBUILD_EXAMPLES=OFF \
       -DBUILD_TESTS=OFF \
       -DBUILD_PERF_TESTS=OFF \
       -DBUILD_WITH_DEBUG_INFO=OFF \
    && make -s \
    && make -s install \
    && rm -rf $OPENCV_SRC_DIR

# Configure OpenCV
RUN echo "$OPENCV_PREFIX/lib" > /etc/ld.so.conf.d/opencv.conf && ldconfig
ENV PKG_CONFIG_PATH $OPENCV_PREFIX/lib/pkgconfig/:$PKG_CONFIG_PATH

# Run Opencv
# CMD ["/usr/bin/pkg-config", "--cflags", "--libs", "opencv"]

# Install app dependencies.
# Use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
COPY package.json /tmp/package.json
WORKDIR /tmp
RUN npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/

# Load applicatoin code in - previous docker "layer"
# (cached) will be used if possible
WORKDIR /opt/app
COPY . /opt/app

# Start the Nodejs application
CMD ["npm", "start"]
