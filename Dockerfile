FROM jupyter/datascience-notebook
USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools gnupg2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip wget build-essential cmake git-all tar gzip curl zlib1g-dev libncurses-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y minimap2 seqtk samtools bedtools vcftools bcftools assemblytics

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

RUN conda create -n mummer --no-default-packages
RUN conda install mummer -n mummer
RUN conda clean --all --yes

RUN conda create -n diamond --no-default-packages
RUN conda install diamond -n diamond
RUN conda clean --all --yes

RUN conda create -n blast --no-default-packages
RUN conda install blast -n blast
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

RUN conda create -n fastqc --no-default-packages
RUN conda install fastqc -n fastqc
RUN conda clean --all --yes

RUN conda create -n multiqc --no-default-packages
RUN conda install multiqc -n multiqc
RUN conda clean --all --yes

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

ENV PATH="${PATH}:/opt/conda/envs/:/opt/conda/envs/mummer/bin:/opt/conda/envs/blast/bin:/opt/conda/envs/diamond/bin:/opt/conda/envs/gatk4/bin:/opt/conda/envs/syri_env/bin:/opt/conda/envs/breakdancer/bin:/opt/conda/envs/fastqc/bin:/opt/conda/envs/multiqc/bin"





