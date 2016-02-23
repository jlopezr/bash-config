if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# MacPorts Installer addition on 2015-11-21_at_16:34:51: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
