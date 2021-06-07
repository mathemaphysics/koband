FROM nvidia/cuda:latest

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y build-essential gfortran git make cmake \
    && apt-get install -y vim libfftw3-dev
RUN apt-get install -y gawk openbabel libopenbabel-dev perl cpanminus \
    && cpanm Template Modern::Perl

WORKDIR /workspace/build
RUN git clone https://github.com/gromacs/gromacs
WORKDIR gromacs/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DGMX_GPU=ON -DGMX_CUDA_TARGET_COMPUTE=61 \
    && make && make install

# Get and build Tinker-8.7.1
#COPY tinker-8.7.1.tar.gz ./
ADD https://dasher.wustl.edu/tinker/downloads/tinker-8.7.1.tar.gz .
RUN tar xvf tinker-8.7.1.tar.gz
WORKDIR tinker
ENV TINKERDIR /workspace/build/tinker
RUN cp ./make/Makefile ./source/
WORKDIR source
RUN sed -i -r -e 's,TINKERDIR = [a-zA-Z0-9)(\$\/]+,TINKERDIR = '$(pwd)',g' \
           -r -e '85,94s/^/#/g' \
           -r -e '69,77s/^#//g' \
           -r -e '69,77s, -L\$[(]TINKER_LIBDIR[)]/linux\s*$,,g' \
           Makefile \
    && make
ENV PATH=${PATH}:/workspace/build/tinker/source
WORKDIR ../..

# Install Packmol
#COPY packmol.tar.gz ./
ADD http://leandro.iqm.unicamp.br/m3g/packmol/packmol.tar.gz .
RUN tar xvf packmol.tar.gz
WORKDIR packmol
ENV PACKMOLDIR /workspace/build/packmol
RUN ./configure && make
ENV PATH=${PATH}:/workspace/build/packmol
WORKDIR ..

# Get Kob-Andersen system generator
RUN git clone https://github.com/mathemaphysics/koband
WORKDIR koband
WORKDIR ..

# Show everyone what we did for credit
CMD ls -Ra .

