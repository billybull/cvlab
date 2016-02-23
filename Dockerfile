# OpenCV lab and testing environment

# Build image and maintainer
FROM centos
MAINTAINER wcbullington

# Dockerfile environment variables initialized
ENV OPENCV_PREFIX /opt/opencv
ENV OPENCV_SRC_DIR $OPENCV_PREFIX/src
ENV OPENCV_VERSION 3.1.0
ENV OPENCV_ARCHIVE_URL https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.tar.gz

# Update system and install OpenCV dependencies
RUN yum update -y && yum install -y \
    make \
    cmake \
    git \
    gcc-c++ \
    && yum clean all

# Install optional OpenCV dependencies
RUN yum install -y \
    python-dev \
    python-numpy \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libdc1394-22-dev \
    && yum clean all

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

# Install Imagemagick and Nodejs
RUN yum install -y \
    imagemagick \
    nodejs \
    && yum clean all

# Install Bower
RUN npm bower -g

# Install Nodejs modules
RUN npm install -g \
    nodemon \
    grunt \
    grunt-cli

# Configure OpenCV
RUN echo "$OPENCV_PREFIX/lib" > /etc/ld.so.conf.d/opencv.conf && ldconfig
ENV PKG_CONFIG_PATH $OPENCV_PREFIX/lib/pkgconfig/:$PKG_CONFIG_PATH

# Install Node app dependencies in package.json
RUN npm install

# Run Opencv
# CMD ["/usr/bin/pkg-config", "--cflags", "--libs", "opencv"]

# Run the Nodejs application
CMD ["node", "index.js"]
