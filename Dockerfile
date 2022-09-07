FROM jupyter/datascience-notebook
USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools gnupg2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip wget build-essential cmake git-all tar gzip curl zlib1g-dev libncurses-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y minimap2 seqtk samtools bedtools vcftools bcftools assemblytics bandage

RUN wget -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add -
RUN echo 'deb http://mirror.oxfordnanoportal.com/apt focal-stable non-free' | tee /etc/apt/sources.list.d/nanoporetech.sources.list
RUN apt-get update

RUN apt-get install -y ont-guppy-cpu

ENV JUPYTER_ENABLE_LAB=yes
ENV PYTHONPATH="/usr/bin/python3.8"

RUN python3 -m pip install matplotlib pandas sniffles
RUN python3 -m pip install PyQt5 ete3 owlready2 pyproteinsExt ipympl jupyterlab
RUN python3 -m pip install --upgrade ipython
RUN python3 -m pip install bash_kernel
RUN python3 -m bash_kernel.install

RUN conda update --all --yes

RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

RUN conda create -n flye --no-default-packages
RUN conda install flye=2.9 -n flye
RUN conda clean --all --yes

RUN conda create -n nanocomp --no-default-packages
RUN conda install nanocomp -n nanocomp
RUN conda clean --all --yes

RUN conda create -n raven-assembler --no-default-packages
RUN conda install raven-assembler -n raven-assembler
RUN conda clean --all --yes

RUN conda create -n ragtag --no-default-packages
RUN conda install ragtag -n ragtag
RUN conda clean --all --yes

RUN conda create -n mummer --no-default-packages
RUN conda install mummer -n mummer
RUN conda clean --all --yes

RUN conda create -n racon --no-default-packages
RUN conda install racon -n racon
RUN conda clean --all --yes

RUN conda create -n assembly-stats --no-default-packages
RUN conda install assembly-stats -n assembly-stats
RUN conda clean --all --yes

RUN conda create -n nanoplot --no-default-packages
RUN conda install nanoplot -n nanoplot
RUN conda clean --all --yes

RUN conda create -n quast --no-default-packages
RUN conda install python=3.7 quast -n quast
RUN conda clean --all --yes

RUN conda create -n blobtools --no-default-packages
RUN conda install blobtools -n blobtools
RUN conda clean --all --yes

RUN conda create -n diamond --no-default-packages
RUN conda install diamond -n diamond
RUN conda clean --all --yes

RUN conda create -n blast --no-default-packages
RUN conda install blast -n blast
RUN conda clean --all --yes

RUN conda create -n medaka --no-default-packages
RUN conda install medaka -n medaka
RUN conda clean --all --yes

RUN conda create -n gatk4 --no-default-packages
RUN conda install gatk4 -n gatk4
RUN conda clean --all --yes

RUN conda create -n breakdancer --no-default-packages
RUN conda install breakdancer -n breakdancer
RUN conda clean --all --yes

RUN conda create -n syri_env --no-default-packages
RUN conda install syri -n syri_env
RUN conda clean --all --yes

RUN conda install -c bioconda perl-config-general perl-gd perl-math-bezier perl-math-round perl-math-vecstat perl-params-validate perl-readonly perl-set-intspan circos

RUN mkdir -p /opt/
RUN cd /opt/ && wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
RUN unzip /opt/snpEff_latest_core.zip
RUN mv snpEff /opt/
RUN ln -s /opt/snpEff/snpEff.jar /usr/bin/snpEff.jar
RUN ln -s /opt/snpEff/SnpSift.jar /usr/bin/SnpSift.jar

## bwa mem2
RUN mkdir -p /opt/bwa-mem2
RUN cd /opt/bwa-mem2 && curl -L https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.0pre2/bwa-mem2-2.0pre2_x64-linux.tar.bz2 | tar jxf -
RUN ln -s /opt/bwa-mem2/bwa-mem2-2.0pre2_x64-linux/bwa-mem2.avx2 /usr/bin/bwa-mem2

ENV PATH="${PATH}:/opt/conda/envs/:/opt/conda/envs/assembly-stats/bin:/opt/conda/envs/blobtools/bin:/opt/conda/envs/flye/bin:/opt/conda/envs/mummer/bin:/opt/conda/envs/nanoplot/bin:/opt/conda/envs/quast/bin:/opt/conda/envs/ragtag/bin:/opt/conda/envs/blast/bin:/opt/conda/envs/diamond/bin:/opt/conda/envs/nanocomp/bin:/opt/conda/envs/racon/bin:/opt/conda/envs/raven-assembler/bin:/opt/conda/envs/medaka/bin:/opt/conda/envs/gatk4/bin:/opt/conda/envs/syri_env/bin:/opt/conda/envs/breakdancer/bin"





