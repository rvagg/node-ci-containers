# extends /opt/app-root/etc/scl_enable and adds ccache

# unset BASH_ENV PROMPT_COMMAND ENV
source scl_source enable devtoolset-7
export PATH=/usr/lib64/ccache:$PATH
