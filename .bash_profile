# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.1-1

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bash_profile file

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi

setproxy ()
{
	export http_proxy=http://proxy.clondiag.jena:8080
	export https_proxy=http://proxy.clondiag.jena:8080
	export ftp_proxy=http://proxy.clondiag.jena:8080
}

unsetproxy ()
{
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
}

setproxy
export DISPLAY=:0
alias apt-cyg-ports='apt-cyg -m ftp://ftp-stud.fht-esslingen.de/pub/Mirrors/sourceware.org/cygwinports/x86'
alias apt-cyg='apt-cyg -m http://ftp.inf.tu-dresden.de/software/windows/cygwin32/x86'
alias ipython='cygstart D:\\apps\\Portable\ Python\ 2.7.3.2\\App\\Scripts\\ipython.exe'
alias wpython='/cygdrive/d/apps/Portable\ Python\ 2.7.3.2/App/python.exe'
alias wpythonw='/cygdrive/d/apps/Portable\ Python\ 2.7.3.2/App/pythonw.exe'
